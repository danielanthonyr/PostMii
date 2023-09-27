//
//  MyProfileView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-25.
//

import Foundation
import UIKit

class MyProfileView: UIView {
    
    // MARK: - Variables
    
    // MARK: - Views
    
    private(set) var profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Profile"
        return label
    }()
    
    private(set) var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log Out", for: .normal)
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
        backgroundColor = .systemBackground
        
        addSubview(profileLabel)
        addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            logoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
