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
    
    private(set) var createTodoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create a TODO"
        return label
    }()
    
    private(set) var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private(set) var todoNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Enter Todo Name"
        return textfield
    }()
    
    private(set) var todoDateTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Enter Todo Date"
        return textfield
    }()
    
    private(set) var todoDescriptionTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Enter Todo Description"
        return textfield
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
        
        textFieldStackView.addArrangedSubview(todoNameTextField)
        textFieldStackView.addArrangedSubview(todoDateTextField)
        textFieldStackView.addArrangedSubview(todoDescriptionTextField)
        
        addSubview(createTodoLabel)
        addSubview(textFieldStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            createTodoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            createTodoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            textFieldStackView.topAnchor.constraint(equalTo: createTodoLabel.bottomAnchor, constant: 16),
            textFieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textFieldStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
