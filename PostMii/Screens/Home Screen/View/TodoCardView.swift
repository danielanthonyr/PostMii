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
    
    var cellVM: TodoCardCellVM? {
        didSet {
            if let cellVM = cellVM {
                setupLabels(todoCardCellVM: cellVM)
            }
        }
    }
    
    // MARK: - Views
    
    private(set) var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = Colors().midnightGrey1
        imageView.tintColor = .systemGray2
        return imageView
    }()
    
    private(set) var nameAndDateStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private(set) var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = AppFont.bold.size(20)
        label.textColor = .white
        return label
    }()
    
    private(set) var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = AppFont.bold.size(20)
        label.textColor = .white
        return label
    }()
    
    private(set) var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = AppFont.semiBold.size(16)
        label.textColor = .white
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
        
        self.cardImageView.image = UIImage(systemName: "list.bullet.clipboard")!
        self.nameLabel.text = todoCardCellVM.name
        self.dateLabel.text = dateFormatter.getShortDateString(date: todoCardCellVM.date)
        self.descriptionLabel.text = todoCardCellVM.description
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        nameAndDateStackview.addArrangedSubview(nameLabel)
        nameAndDateStackview.addArrangedSubview(dateLabel)
        
        addSubview(cardImageView)
        addSubview(nameAndDateStackview)
        addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardImageView.heightAnchor.constraint(equalTo: heightAnchor),
            
            nameAndDateStackview.topAnchor.constraint(equalTo: cardImageView.centerYAnchor, constant: 16),
            nameAndDateStackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameAndDateStackview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameAndDateStackview.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        bringSubviewToFront(nameAndDateStackview)
    }
}
