//
//  EmptyTodoCardDeckView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-10-23.
//

import Foundation
import UIKit

class EmptyTodoCardDeckView: UIView {
    
    // MARK: - Variables
    
    // MARK: - Views
    
    private(set) var emptyCardDeckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.tintColor = .systemGray2
        imageView.image = UIImage(named: "empty-box")
        return imageView
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFont.semiBold.size(20)
        label.textColor = .black
        label.text = "Looks like we're done here!"
        label.textAlignment = .center
        return label
    }()
    
    private(set) var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = AppFont.semiBold.size(16)
        label.textColor = .lightGray
        label.text = "No more TODO's left to display! Great Job!"
        label.textAlignment = .center
        return label
    }()
    
    var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reload TODO's", for: .normal)
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
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubview(emptyCardDeckImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(reloadButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyCardDeckImageView.topAnchor.constraint(equalTo: topAnchor),
            emptyCardDeckImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyCardDeckImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyCardDeckImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            titleLabel.topAnchor.constraint(equalTo: emptyCardDeckImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            reloadButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            reloadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
