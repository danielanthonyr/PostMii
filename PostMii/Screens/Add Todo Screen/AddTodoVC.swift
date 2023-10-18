//
//  AddTodoVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation
import UIKit

class AddTodoVC: UIViewController {
    
    // MARK: - Variables
    
    private let views = AddTodoView()
    private(set) var viewModel = AddTodoVM()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
    }
    
    // MARK: - Methods
    
    private func setupSelf() {
        views.todoNameTextField.delegate = self
        views.todoDateTextField.delegate = self
        views.todoDescriptionTextField.delegate = self
        
        views.todoDateTextField.inputView = views.datePicker
        views.datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        views.createTodoButton.addTarget(self, action: #selector(createTodoButtonClicked(sender:)), for: .touchUpInside)
        views.editImageViewButton.addTarget(self, action: #selector(todoImageViewPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func todoImageViewPressed(sender: UIImageView) {
        showImagePicker()
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        views.todoDateTextField.text = dateFormatter.string(from: sender.date)
        viewModel.updateTodoDate(date: sender.date)
        views.todoDateTextField.resignFirstResponder()
    }
    
    @objc func createTodoButtonClicked(sender: UIButton) {
        guard let todoNameText = views.todoNameTextField.text, !todoNameText.isEmpty else {
            self.displayAlertMessage(title: "Missing Name", message: "Please fill out the Todo Name field")
            return
        }
        
        guard let todoDateText = views.todoDateTextField.text, !todoDateText.isEmpty else {
            self.displayAlertMessage(title: "Missing Date", message: "Please fill out the Todo Date field")
            return
        }
        
        guard let todoDescriptionText = views.todoDescriptionTextField.text, !todoDescriptionText.isEmpty else {
            self.displayAlertMessage(title: "Missing Description", message: "Please fill out the Todo Description field")
            return
        }
        
        // Add todo to the backend
        viewModel.createTodoInFirebaseDB(name: todoNameText, description: todoDescriptionText)
    }
    
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension AddTodoVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case views.todoNameTextField:
            views.todoDateTextField.becomeFirstResponder()
        case views.todoDateTextField:
            views.todoDescriptionTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}

// MARK: - UIImagePickerController

extension AddTodoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Upload view image
            views.cardImageView.image = selectedImage
            
            uploadTodoPhotoToFirebase(selectedImage: selectedImage, picker: picker)
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    // TODO: Once get this working, migrate logic to it's own service class and call from VM, and remove firebase imports
    private func uploadTodoPhotoToFirebase(selectedImage: UIImage, picker: UIImagePickerController) {
        // Convert the selected image to Data
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            // Upload the image to Firebase Storage
            self.viewModel.imageData = imageData
        }
    }
}
