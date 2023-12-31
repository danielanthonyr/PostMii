//
//  LoginView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-26.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    // MARK: - Variables
    
    // MARK: - Views
    
    private(set) var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.isHidden = true
        return spinner
    }()
    
    private(set) var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        return textField
    }()
    
    private(set) var passwordTextfield: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private(set) var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.layer.borderWidth = 2.0 // Set the width of the border
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 20.0 // Adjust the value for the desired corner radius
        // Clips to bounds ensures that the content inside the button doesn't extend beyond the rounded corners
        button.clipsToBounds = true
        return button
    }()
    
    private(set) var createNewAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create new account", for: .normal)
        button.layer.borderWidth = 2.0 // Set the width of the border
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 20.0 // Adjust the value for the desired corner radius
        // Clips to bounds ensures that the content inside the button doesn't extend beyond the rounded corners
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        backgroundColor = .white
        
        addSubview(spinner)
        addSubview(emailTextField)
        addSubview(passwordTextfield)
        addSubview(loginButton)
        addSubview(createNewAccountButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextfield.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextfield.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            passwordTextfield.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            createNewAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
            createNewAccountButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            createNewAccountButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            createNewAccountButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
