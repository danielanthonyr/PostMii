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
    
    private(set) var profileContentStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private(set) var profilePicImageView: CircleImageView = {
        let imageView = CircleImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private(set) var profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    private(set) var todosCompletedLabel: UILabel = {
        let label = UILabel()
        label.text = "Todos Completed: "
        return label
    }()
    
    private(set) var todosMissedLabel: UILabel = {
        let label = UILabel()
        label.text = "Todos Missed: "
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
        
        profileContentStackview.addArrangedSubview(profileNameLabel)
        profileContentStackview.addArrangedSubview(todosCompletedLabel)
        profileContentStackview.addArrangedSubview(todosMissedLabel)
        
        addSubview(profilePicImageView)
        addSubview(profileContentStackview)
        addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profilePicImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            profilePicImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profilePicImageView.heightAnchor.constraint(equalToConstant: 100),
            profilePicImageView.widthAnchor.constraint(equalToConstant: 100),
            
            profileContentStackview.topAnchor.constraint(equalTo: profilePicImageView.bottomAnchor, constant: 32),
            profileContentStackview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileContentStackview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            logoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
