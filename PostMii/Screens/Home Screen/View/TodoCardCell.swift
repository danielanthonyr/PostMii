//
//  TodoCardCell.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation
import UIKit

class TodoCardCell: UICollectionViewCell {
    
    // MARK: - Variables
    
    static let reuseIdentifier = "TodoCardViewCell"
    
    var cellVM: TodoCardCellVM? {
        didSet {
            if let cellVM = cellVM {
                todoCardView.setupLabels(todoCardCellVM: cellVM)
            }
        }
    }
    
    // MARK: - Views
    
    private(set) var todoCardView: TodoCardView = {
        let todoCardView = TodoCardView()
        todoCardView.translatesAutoresizingMaskIntoConstraints = false
        return todoCardView
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
        contentView.addSubview(todoCardView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            todoCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            todoCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            todoCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            todoCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
