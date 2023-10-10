//
//  MyProfileVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-25.
//

import Foundation
import UIKit
import FirebaseAuth

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
        
        views.logoutButton.addTarget(self, action: #selector(logoutButtonPressed(sender:)), for: .touchUpInside)
    }
    
    private func setupViewModel() {
        viewModel.loadUserProfilePage = { [weak self] in
            guard let self = self, self.viewModel.getMyProfileError == nil else { return }
            
            views.setupProfileLabels(with: viewModel.myProfile)
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
            print("Error signing out: \(signOutError)")
        }
    }
    
    private func redirectToLoginPage() {
        let loginVC = LoginVC()
        let rootVC = UINavigationController(rootViewController: loginVC)
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(rootVC)
    }
}
