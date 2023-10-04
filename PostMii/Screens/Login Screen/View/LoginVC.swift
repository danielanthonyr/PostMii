//
//  LoginVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-26.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    // MARK: - Variables
    
    private let views = LoginView()
    private let viewModel = LoginVM()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
    }
    
    private func setupSelf() {
        self.title = "Login"
        self.views.loginButton.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
        self.views.createNewAccountButton.addTarget(self, action: #selector(createNewAccountButtonTapped(sender:)), for: .touchUpInside)
    }
    
    private func setupViewModel() {
        
    }
    
    // MARK: - Methods
    
    @objc func loginButtonTapped(sender: UIButton) {
        guard let todoEmailString = views.emailTextField.text, !todoEmailString.isEmpty else {
            // show error message
            showTextFieldValidationError(with: "Email")
            return
        }
        
        guard let todoPasswordString = views.passwordTextfield.text, !todoPasswordString.isEmpty else {
            showTextFieldValidationError(with: "Password")
            return
        }
        
        let email = todoEmailString
        let password = todoPasswordString
        signIn(email: email, password: password)
    }
    
    @objc func createNewAccountButtonTapped(sender: UIButton) {
        let signUpVC = SignUpVC()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func showTextFieldValidationError(with string: String) {
        // create the alert
        let alert = UIAlertController(title: "Missing Entry", message: "Please fill out the \(string) field.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.wrongPassword.rawValue:
                    self.displayAlertMessage(title: "Password", message: "Invalid Password")
                case AuthErrorCode.invalidEmail.rawValue:
                    self.displayAlertMessage(title: "Email", message: "Invalid Email")
                case AuthErrorCode.userNotFound.rawValue:
                    self.displayAlertMessage(title: "User Not Found",
                                             message: "Account does not exist. Please sign up first")
                case AuthErrorCode.networkError.rawValue:
                    self.displayAlertMessage(title: "Network Issue",
                                             message: "Network Error, please check your internet connection")
                default:
                    print(err.code)
                    self.displayAlertMessage(title: "Sign In Error",
                                             message: "Sign in error. Please report to development team")
                }
                
            } else {
                // The user is signed in; perform any required actions (e.g., navigate to the main screen)
                if let userUID = authResult?.user.uid {
                    self.redirectToHomeTabBarController(userUID: userUID)
                } else {
                    print("No user UID")
                }
            }
        }
    }
    
    private func redirectToHomeTabBarController(userUID: String) {
        let TabBarController = TabBarController()
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(TabBarController, userId: userUID)
    }
}
