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
        setupViewModel()
    }
    
    private func setupSelf() {
        self.title = "Login"
        self.views.loginButton.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
        self.views.createNewAccountButton.addTarget(self, action: #selector(createNewAccountButtonTapped(sender:)), for: .touchUpInside)
    }
    
    private func setupViewModel() {
        viewModel.loginTriggered = { [weak self] in
            guard let self = self else { return }
            
            if let error = viewModel.loginError {
                hideSpinner()
                
                self.displayAlertMessage(
                    title: error.localizedDescription.title,
                    message: error.localizedDescription.message
                )
                return
            }
            
            hideSpinner()
            
            if let uid = viewModel.user.uid {
                self.redirectToHomeTabBarController(userUID: uid)
            } else {
                self.displayAlertMessage(
                    title: "User uid invalid",
                    message: "No User uid, please try again"
                )
            }
        }
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
        viewModel.login(email: email, password: password)
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
    
    private func redirectToHomeTabBarController(userUID: String) {
        let TabBarController = TabBarController()
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(TabBarController, userId: userUID)
    }
    
    private func hideSpinner() {
        views.spinner.stopAnimating()
    }
}
