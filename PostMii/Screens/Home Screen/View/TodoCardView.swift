//
//  CardView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation
import UIKit


class TodoCardView: UIView {
    
    // MARK: - Variables
    
    
    // MARK: - Views
    
    private(set) var nameAndDateStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private(set) var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private(set) var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private(set) var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
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
    
    func setupLabels(todoCardCellVM: TodoCardCellVM) {
        let dateFormatter = DateFormatter()
        
        self.nameLabel.text = todoCardCellVM.name
        self.dateLabel.text = dateFormatter.getShortDateString(date: todoCardCellVM.date)
        self.descriptionLabel.text = todoCardCellVM.description
    }
    
    func setupViews() {
        nameAndDateStackview.addArrangedSubview(nameLabel)
        nameAndDateStackview.addArrangedSubview(dateLabel)
        
        addSubview(nameAndDateStackview)
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameAndDateStackview.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameAndDateStackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameAndDateStackview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameAndDateStackview.bottomAnchor, constant: 32),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
