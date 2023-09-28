//
//  HomeCalendarView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-25.
//

import Foundation
import UIKit

class HomeCalendarView: UIView {
    
    // MARK: - Variables
    
    
    // MARK: - Views
    
    private(set) var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mon, 24 Sep"
        label.font = AppFont.bold.size(24)
        return label
    }()
    
    private(set) var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .lightGray
        return imageView
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
        
        addSubview(dateLabel)
        addSubview(chevronImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            chevronImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
