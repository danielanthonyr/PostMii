//
//  MyProfileVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-25.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import SkeletonView

class MyProfileVC: UIViewController {
    
    // MARK: - Variables
    
    private let views = MyProfileView()
    private let viewModel = MyProfileVM()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
        setupViewModel()
    }
    
    // MARK: - Methods
    
    private func setupSelf() {
        self.title = "My Profile"
        
        showShimmer()
        
        views.logoutButton.addTarget(self, action: #selector(logoutButtonPressed(sender:)), for: .touchUpInside)
        views.cameraCirclePictureView.addTarget(self, action: #selector(profilePicImageViewPressed(sender:)), for: .touchUpInside)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profilePicImageViewPressed(sender:)))
        views.profilePicImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupViewModel() {
        viewModel.loadUserProfilePage = { [weak self] in
            guard let self = self, self.viewModel.getMyProfileError == nil else { return }
            
            views.setupProfileLabels(with: viewModel.myProfile)
            
            if let profilePicURL = viewModel.myProfile.profilePicURL {
                downloadAndDisplayImage(from: profilePicURL) { err in
                    if let error = err {
                        self.displayAlertMessage(
                            title: "Error fetching profile picture",
                            message: error.localizedDescription
                        )
                    }
                    self.hideShimmer()
                }
            } else {
                self.hideShimmer()
            }
        }
        
        viewModel.getMyProfile()
    }
    
    @objc func logoutButtonPressed(sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
            redirectToLoginPage()
            // User is signed out
            // You can perform any additional actions here, such as navigating to a login screen
        } catch let signOutError as NSError {
            self.displayAlertMessage(title: "Sign Out Error", message: signOutError.localizedDescription)
        }
    }
    
    @objc func profilePicImageViewPressed(sender: UIImageView) {
        showImagePicker()
    }
    
    private func showShimmer() {
        views.profileContentStackview.showAnimatedGradientSkeleton()
        views.profileCircleViewContainer.showAnimatedGradientSkeleton()
    }
    
    private func hideShimmer() {
        views.profileCircleViewContainer.hideSkeleton()
        views.profileContentStackview.hideSkeleton()
    }
    
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func redirectToLoginPage() {
        let loginVC = LoginVC()
        let rootVC = UINavigationController(rootViewController: loginVC)
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(rootVC)
    }
    
    private func downloadAndDisplayImage(from url: URL, completion: @escaping ((Error?)-> Void)) {
        let storageRef = Storage.storage().reference(forURL: url.absoluteString)

        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                self.displayAlertMessage(title: "Database Error", message: "Error downloading image from database")
                // Handle error or display a placeholder image
                completion(error)
            } else if let data = data, let image = UIImage(data: data) {
                // Now you have the image, you can display it in an UIImageView
                self.views.profilePicImageView.image = image
                completion(nil)
            }
        }
    }
}

// MARK: - UIImagePickerController

extension MyProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Upload view image
            views.profilePicImageView.image = selectedImage
            
            uploadPhotoToFirebase(selectedImage: selectedImage, picker: picker)
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Handle when the user cancels the image picker
        picker.dismiss(animated: true, completion: nil)
    }
    
    // TODO: Once get this working, migrate logic to it's own service class and call from VM, and remove firebase imports
    private func uploadPhotoToFirebase(selectedImage: UIImage, picker: UIImagePickerController) {
        // Upload the new profile pic to firebase
        let imageUUID = UUID().uuidString
        let storageRef = Storage.storage().reference().child("images/\(imageUUID).jpg")
        
        // Convert the selected image to Data
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            // Upload the image to Firebase Storage
            _ = storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    self.displayAlertMessage(title: "Image Upload Error", message: error.localizedDescription)
                } else {
                    // Image uploaded successfully, now store the download URL in Firebase Realtime Database
                    storageRef.downloadURL { (url, error) in
                        if let error = error {
                            self.displayAlertMessage(title: "Download URL error", message: error.localizedDescription)
                        } else if let downloadURL = url?.absoluteString, let user = Auth.auth().currentUser {
                            let changeRequest = user.createProfileChangeRequest()
                            changeRequest.photoURL = URL(string: downloadURL)
                            
                            changeRequest.commitChanges { error in
                                if error != nil {
                                    guard let message = error?.localizedDescription else { return }
                                    self.displayAlertMessage(title: "Error uploading profile picture to Database", message: message)
                                    return
                                }
                                print("profile pic url saved successfully")
                                picker.dismiss(animated: true, completion: nil)
                            }
                            
                        } else {
                            self.displayAlertMessage(title: "User Authentication Error", message: "You are not logged in")
                        }
                    }
                }
            }
        }
    }
}
