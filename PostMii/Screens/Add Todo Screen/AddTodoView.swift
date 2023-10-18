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
    
    private(set) var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "list.bullet.clipboard")!
        imageView.clipsToBounds = true
        imageView.backgroundColor = Colors().midnightGrey1
        imageView.tintColor = .systemGray2
        return imageView
    }()
    
    private(set) var editImageViewButton: UIButton = {
        let button = CircleButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSkeletonable = true
        button.backgroundColor = Colors().minty1
        button.tintColor = Colors().midnightGrey1
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        return button
    }()
    
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
    
    private func setupViews() {
        backgroundColor = .white
        
        textFieldStackView.addArrangedSubview(todoNameTextField)
        textFieldStackView.addArrangedSubview(todoDateTextField)
        textFieldStackView.addArrangedSubview(todoDescriptionTextField)
        
        addSubview(createTodoLabel)
        addSubview(cardImageView)
        addSubview(editImageViewButton)
        addSubview(textFieldStackView)
        addSubview(createTodoButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            createTodoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            createTodoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            cardImageView.topAnchor.constraint(equalTo: createTodoLabel.bottomAnchor, constant: 16),
            cardImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            cardImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            editImageViewButton.topAnchor.constraint(equalTo: cardImageView.topAnchor, constant: 16),
            editImageViewButton.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: -16),
            editImageViewButton.heightAnchor.constraint(equalToConstant: 40),
            editImageViewButton.widthAnchor.constraint(equalToConstant: 40),
            
            textFieldStackView.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 16),
            textFieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textFieldStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            createTodoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            createTodoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            createTodoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            createTodoButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
