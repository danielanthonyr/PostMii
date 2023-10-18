//
//  TodoDetailsView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-10-10.
//

import Foundation
import UIKit

class TodoDetailsView: UIView {
    
    // MARK: - Variables
    
    // MARK: - Views
    
    private(set) var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private(set) var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private(set) var todoNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = AppFont.semiBold.size(20)
        textField.textColor = .black
        return textField
    }()
    
    private(set) var todoDateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = AppFont.semiBold.size(20)
        textField.textColor = .black
        return textField
    }()
    
    private(set) var todoDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = AppFont.semiBold.size(16)
        textField.textColor = .lightGray
        return textField
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
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupCardViewDetails(todoCardCellVM: TodoCardCellVM) {
        let dateFormatter = DateFormatter()
        
        self.cardImageView.image = UIImage(systemName: "list.bullet.clipboard")!
        self.todoNameTextField.text = todoCardCellVM.name
        self.todoDateTextField.text = dateFormatter.getShortDateWithTimeString(date: todoCardCellVM.date)
        self.todoDescriptionTextField.text = todoCardCellVM.description
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        labelStackView.addArrangedSubview(todoNameTextField)
        labelStackView.addArrangedSubview(todoDateTextField)
        labelStackView.addArrangedSubview(todoDescriptionTextField)
        
        addSubview(cardImageView)
        addSubview(editImageViewButton)
        addSubview(labelStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            cardImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            editImageViewButton.topAnchor.constraint(equalTo: cardImageView.topAnchor, constant: 16),
            editImageViewButton.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: -16),
            editImageViewButton.heightAnchor.constraint(equalToConstant: 40),
            editImageViewButton.widthAnchor.constraint(equalToConstant: 40),
            
            labelStackView.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 16),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
