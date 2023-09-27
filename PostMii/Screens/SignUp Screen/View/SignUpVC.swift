//
//  SignUpVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-27.
//

import Foundation
import UIKit
import FirebaseAuth

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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func setupSelf() {
        self.title = "Sign Up"
        self.views.signUpButton.addTarget(self, action: #selector(signUpButtonTapped(sender:)), for: .touchUpInside)
    }
    
    func setupViewModel() {
        
    }
    
    // MARK: - Methods
    
    @objc func signUpButtonTapped(sender: UIButton) {
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
        
        let email = userEmailString
        let password = todoPasswordString
        createUser(email: email, password: password)
    }
    
    func createUser(email: String, password: String) {
        showSpinner()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            self.hideSpinner()
            
            if let error = error {
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.operationNotAllowed.rawValue:
                    self.displayAlertMessage(title: "Operation Not Allowed", message: "Sign Up service is disabled")
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    self.displayAlertMessage(title: "Email Already in use", message: "Email is already in use")
                case AuthErrorCode.invalidEmail.rawValue:
                    self.displayAlertMessage(title: "Invalid Email",
                                             message: "Invalid Email. Please enter a valid email")
                case AuthErrorCode.weakPassword.rawValue:
                    self.displayAlertMessage(title: "Weak Password",
                                             message: "Weak Password. Please choose a better password")
                default:
                    print(err.code)
                    self.displayAlertMessage(title: "Sign Up Error",
                                             message: "Sign up error. Please report to development team")
                }
            }
            
            if let user = authResult?.user {
                self.redirectToHomeTabBarController(userUID: user.uid)
            }
        }
    }
    
    private func redirectToHomeTabBarController(userUID: String) {
        let TabBarController = TabBarController()
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(TabBarController, userId: userUID)
    }
    
    func showSpinner() {
        views.spinner.startAnimating()
    }
    
    func hideSpinner() {
        views.spinner.stopAnimating()
    }
}
