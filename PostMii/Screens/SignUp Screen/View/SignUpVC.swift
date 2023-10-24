//
//  SignUpVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-27.
//

import Foundation
import UIKit

class SignUpVC: UIViewController {
    
    // MARK: - Variables
    
    private let views = SignUpView()
    private let viewModel = SignUpVM()
    
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
    
    func showSpinner() {
        views.spinner.startAnimating()
    }
    
    func createUser(userFullName: String, email: String, password: String) {
        showSpinner()
        viewModel.createAccount(withFullname: userFullName, withEmail: email, withPassword: password)
    }
    
    private func setupSelf() {
        self.title = "Sign Up"
        self.views.signUpButton.addTarget(self, action: #selector(signUpButtonTapped(sender:)), for: .touchUpInside)
    }
    
    private func setupViewModel() {
        viewModel.accountCreated = { [weak self] in
            guard let self = self else { return }
            
            if let error = viewModel.accountCreatedError {
                hideSpinner()
                self.displayAlertMessage(
                    title: error.localizedDescription.title,
                    message: error.localizedDescription.message
                )
                return
            }
            
            hideSpinner()
            self.redirectToHomeTabBarController()
        }
    }
    
    @objc func signUpButtonTapped(sender: UIButton) {
        guard let userNameString = views.nameTextField.text, !userNameString.isEmpty else {
            // show error message
            self.displayAlertMessage(title: "Missing Entry", message: "Please fill out the name field.")
            return
        }
        
        guard let userEmailString = views.emailTextfield.text, !userEmailString.isEmpty else {
            // show error message
            self.displayAlertMessage(title: "Missing Entry", message: "Please fill out the email field.")
            return
        }
        
        guard let todoPasswordString = views.passwordTextfield.text, !todoPasswordString.isEmpty else {
            self.displayAlertMessage(title: "Missing Entry", message: "Please fill out the password field.")
            return
        }
        
        guard let confirmPasswordString = views.confirmPasswordTextfield.text, !confirmPasswordString.isEmpty else {
            self.displayAlertMessage(
                title: "Missing Entry",
                message: "Please fill out the confirm password field."
            )
            return
        }
        
        guard todoPasswordString == confirmPasswordString else {
            self.displayAlertMessage(
                title: "Password Confirmation Error",
                message: "Passwords do not match. Please make sure passwords are identical"
            )
            return
        }
        
        let name = userNameString
        let email = userEmailString
        let password = todoPasswordString
        createUser(userFullName: name, email: email, password: password)
    }
    
    private func redirectToHomeTabBarController() {
        let TabBarController = TabBarController()
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(TabBarController)
    }
    
    private func hideSpinner() {
        views.spinner.stopAnimating()
    }
}
