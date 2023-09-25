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
    
    private(set) lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            datePicker.datePickerMode = .date
        }
        
        datePicker.timeZone = TimeZone.current
        return datePicker
    }()
    
    private(set) var createTodoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create TODO", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 10.0
        button.layer.masksToBounds = true
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
        
        textFieldStackView.addArrangedSubview(todoNameTextField)
        textFieldStackView.addArrangedSubview(todoDateTextField)
        textFieldStackView.addArrangedSubview(todoDescriptionTextField)
        
        addSubview(createTodoLabel)
        addSubview(textFieldStackView)
        addSubview(createTodoButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            createTodoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            createTodoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            textFieldStackView.topAnchor.constraint(equalTo: createTodoLabel.bottomAnchor, constant: 16),
            textFieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textFieldStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            createTodoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            createTodoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            createTodoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            createTodoButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
