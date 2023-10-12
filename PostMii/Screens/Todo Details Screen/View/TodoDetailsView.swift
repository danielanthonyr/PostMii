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
    
    private(set) var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private(set) var todoNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFont.semiBold.size(20)
        label.textColor = .black
        return label
    }()
    
    private(set) var todoDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFont.semiBold.size(20)
        label.textColor = .black
        return label
    }()
    
    private(set) var todoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFont.semiBold.size(16)
        label.textColor = .lightGray
        return label
    }()
    
//    private(set) var editTodoButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Done", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.layer.borderColor = UIColor.gray.cgColor
//        button.layer.borderWidth = 1.5
//        button.layer.cornerRadius = 10.0
//        button.layer.masksToBounds = true
//        return button
//    }()
    
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
        self.todoNameLabel.text = todoCardCellVM.name
        self.todoDateLabel.text = dateFormatter.getShortDateWithTimeString(date: todoCardCellVM.date)
        self.todoDescriptionLabel.text = todoCardCellVM.description
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        labelStackView.addArrangedSubview(todoNameLabel)
        labelStackView.addArrangedSubview(todoDateLabel)
        labelStackView.addArrangedSubview(todoDescriptionLabel)
        
        addSubview(cardImageView)
        addSubview(labelStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            cardImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            labelStackView.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 16),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
//            editTodoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
//            editTodoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            editTodoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            editTodoButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
