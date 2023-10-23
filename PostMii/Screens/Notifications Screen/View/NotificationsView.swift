//
//  NotificationsView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-25.
//

import Foundation
import UIKit

class NotificationsView: UIView {
    
    // MARK: - Variables
    
    // MARK: - Views
    
    private(set) var notificationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Notifications"
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
    
    func setupViews() {
        backgroundColor = .systemGray6
        
        addSubview(notificationsLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            notificationsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            notificationsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
