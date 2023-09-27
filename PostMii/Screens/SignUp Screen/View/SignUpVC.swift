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
    
    func setupSelf() {
        self.title = "Login"
        self.views.signUpButton.addTarget(self, action: #selector(signUpButtonTapped(sender:)), for: .touchUpInside)
    }
    
    func setupViewModel() {
        
    }
    
    // MARK: - Methods
    
    @objc func signUpButtonTapped(sender: UIButton) {
        guard let userEmailString = views.emailTextfield.text, !userEmailString.isEmpty else {
            // show error message
            showTextFieldValidationError(with: "Email")
            return
        }
        
        guard let todoPasswordString = views.passwordTextfield.text, !todoPasswordString.isEmpty else {
            showTextFieldValidationError(with: "Password")
            return
        }
        
        guard let confirmPasswordString = views.confirmPasswordTextfield.text, !confirmPasswordString.isEmpty else {
            showTextFieldValidationError(with: "", passwordConfirmationError: true)
            return
        }
        
        let email = userEmailString
        let password = todoPasswordString
        createUser(email: email, password: password)
    }
    
    func showTextFieldValidationError(with string: String, passwordConfirmationError: Bool = false) {
        // create the alert
        var errorTitle = "Missing Entry"
        var errorMessage = "Please fill out the \(string) field."
        if passwordConfirmationError {
            errorTitle = "Password Confirmation Errror"
            errorMessage = "Passwords do not match. Please make sure passwords are identical"
        }
        
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func createUser(email: String, password: String) {
        showSpinner()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    // [START_EXCLUDE]
                    self.hideSpinner()
                    guard let user = authResult?.user, error == nil else {
                        self.showMessagePrompt(message: error!.localizedDescription)
                        return
                    }
                    print("\(user.email!) created")
                    
                    // Navigate to home screen
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func showSpinner() {
        views.spinner.startAnimating()
    }
    
    func hideSpinner() {
        views.spinner.stopAnimating()
    }
    
    func showMessagePrompt(message: String) {
        // create the alert
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
