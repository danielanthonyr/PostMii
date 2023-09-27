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
    
    private(set) var usernameTextfield: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        return textField
    }()
    
    private(set) var passwordTextfield: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        return textField
    }()
    
    private(set) var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        return button
    }()
    
    private(set) var createNewAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create new account", for: .normal)
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
    
    func setupViews() {
        backgroundColor = .white
        
        addSubview(usernameTextfield)
        addSubview(passwordTextfield)
        addSubview(loginButton)
        addSubview(createNewAccountButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            usernameTextfield.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            usernameTextfield.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            usernameTextfield.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextfield.topAnchor.constraint(equalTo: usernameTextfield.bottomAnchor, constant: 16),
            passwordTextfield.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            passwordTextfield.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.bottomAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            createNewAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            createNewAccountButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            createNewAccountButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            createNewAccountButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
