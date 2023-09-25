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
        backgroundColor = .cyan
        
        addSubview(profileLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
