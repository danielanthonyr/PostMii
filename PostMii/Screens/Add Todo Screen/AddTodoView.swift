//
//  AddTodoView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation
import UIKit

class AddTodoView: UIView {
    
    // MARK: - Variables
    
    // MARK: - Views
    
    private(set) var addTodoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add TODO"
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
        backgroundColor = .white
        
        addSubview(addTodoLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            addTodoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            addTodoLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
