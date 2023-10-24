//
//  MyProfileView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-25.
//

import Foundation
import UIKit
import SkeletonView

class MyProfileView: UIView {
    
    // MARK: - Variables
    
    // MARK: - Views
    
    private(set) var profileContentStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isSkeletonable = true
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private(set) var profileCircleViewContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.isSkeletonable = true
        return container
    }()
    
    private(set) var cameraCirclePictureView: UIButton = {
        let button = CircleButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSkeletonable = true
        button.backgroundColor = Colors().minty1
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(UIImage(systemName: "camera.circle"), for: .normal)
        return button
    }()
    
    private(set) var profilePicImageView: CircleImageView = {
        let imageView = CircleImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isSkeletonable = true
        imageView.image = UIImage(named: "default_profile_pic")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private(set) var profileNameLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.text = "Name"
        return label
    }()
    
    private(set) var profileNameEmailLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.text = "Email"
        return label
    }()
    
//    private(set) var todosCompletedLabel: UILabel = {
//        let label = UILabel()
//        label.isSkeletonable = true
//        label.text = "Todos Completed: "
//        return label
//    }()
//    
//    private(set) var todosMissedLabel: UILabel = {
//        let label = UILabel()
//        label.isSkeletonable = true
//        label.text = "Todos Missed: "
//        return label
//    }()
    
    private(set) var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.isSkeletonable = true
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
    
    func setupProfileLabels(with myProfile: MyProfile) {
        profileNameLabel.text = myProfile.fullName
        profileNameEmailLabel.text = myProfile.email
    }
    
    private func setupViews() {
        backgroundColor = .systemGray6
        
        profileContentStackview.addArrangedSubview(profileNameLabel)
        profileContentStackview.addArrangedSubview(profileNameEmailLabel)
//        profileContentStackview.addArrangedSubview(todosCompletedLabel)
//        profileContentStackview.addArrangedSubview(todosMissedLabel)
        
        profileCircleViewContainer.addSubview(profilePicImageView)
        profileCircleViewContainer.addSubview(cameraCirclePictureView)
        
        addSubview(profileCircleViewContainer)
        addSubview(profileContentStackview)
        addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileCircleViewContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            profileCircleViewContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileCircleViewContainer.heightAnchor.constraint(equalToConstant: 150),
            profileCircleViewContainer.widthAnchor.constraint(equalToConstant: 150),
            
            profilePicImageView.topAnchor.constraint(equalTo: profileCircleViewContainer.topAnchor),
            profilePicImageView.leadingAnchor.constraint(equalTo: profileCircleViewContainer.leadingAnchor),
            profilePicImageView.trailingAnchor.constraint(equalTo: profileCircleViewContainer.trailingAnchor),
            profilePicImageView.bottomAnchor.constraint(equalTo: profileCircleViewContainer.bottomAnchor),
            
            cameraCirclePictureView.bottomAnchor.constraint(equalTo: profileCircleViewContainer.bottomAnchor),
            cameraCirclePictureView.trailingAnchor.constraint(equalTo: profileCircleViewContainer.trailingAnchor),
            cameraCirclePictureView.heightAnchor.constraint(equalToConstant: 30),
            cameraCirclePictureView.widthAnchor.constraint(equalToConstant: 30),
            
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
