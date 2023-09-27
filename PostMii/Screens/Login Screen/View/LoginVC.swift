//
//  LoginVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-26.
//

import Foundation
import UIKit

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
    
    func setupSelf() {
        self.title = "Login"
        self.views.loginButton.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
        self.views.createNewAccountButton.addTarget(self, action: #selector(createNewAccountButtonTapped(sender:)), for: .touchUpInside)
    }
    
    func setupViewModel() {
        
    }
    
    // MARK: - Methods
    
    @objc func loginButtonTapped(sender: UIButton) {
        guard let todoUsernameString = views.usernameTextfield.text, !todoUsernameString.isEmpty else {
            // show error message
            showTextFieldValidationError(with: "Username")
            return
        }
        
        guard let todoPasswordString = views.passwordTextfield.text, !todoPasswordString.isEmpty else {
            showTextFieldValidationError(with: "Password")
            return
        }
        
        let username = todoUsernameString
        let password = todoPasswordString
        loginFirebase(username: username, password: password)
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
    
    func loginFirebase(username: String, password: String) {
        
    }
}
