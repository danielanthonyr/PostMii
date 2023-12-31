//
//  CardView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation
import UIKit
import Koloda
import FirebaseStorage

class TodoCardView: UIView {
    
    // MARK: - Variables
    
    var cellVM: TodoCardCellVM? {
        didSet {
            if let cellVM = cellVM {
                setupTodoCardView(todoCardCellVM: cellVM)
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
    
    private(set) var todoContentStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private(set) var nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.semiBold.size(20)
        label.textColor = .black
        return label
    }()
    
    private(set) var dateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.semiBold.size(20)
        label.textColor = .black
        return label
    }()
    
    private(set) var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.sizeToFit()
        label.font = AppFont.semiBold.size(16)
        label.textColor = .lightGray
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
    
    func setupTodoCardView(todoCardCellVM: TodoCardCellVM) {
        let dateFormatter = DateFormatter()
        
        if let todoCardPhotoURL = todoCardCellVM.todoPhotoURL, todoCardPhotoURL != "" {
            downloadAndDisplayImage(from: URL(string:todoCardPhotoURL)!) { error in
                if let error = error {
                    print("todo card photo URL error: \(error.localizedDescription)")
                }
            }
        } else {
            self.cardImageView.image = UIImage(systemName: "list.bullet.clipboard")!
        }
        self.nameLabel.text = todoCardCellVM.name
        self.dateLabel.text = dateFormatter.getShortDateWithTimeString(date: todoCardCellVM.date)
        self.descriptionLabel.text = todoCardCellVM.description
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        todoContentStackview.addArrangedSubview(nameLabel)
        todoContentStackview.addArrangedSubview(dateLabel)
        todoContentStackview.addArrangedSubview(descriptionLabel)
        
        addSubview(cardImageView)
        addSubview(todoContentStackview)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            
            todoContentStackview.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 16),
            todoContentStackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            todoContentStackview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    // TODO: figure out where to call this, just want to get it working for now
    private func downloadAndDisplayImage(from url: URL, completion: @escaping ((Error?)-> Void)) {
        let storageRef = Storage.storage().reference(forURL: url.absoluteString)

        storageRef.getData(maxSize: 1 * 1024 * 1024 * 1024) { data, error in
            if let error = error {
                // Handle error or display a placeholder image
                completion(error)
            } else if let data = data, let image = UIImage(data: data) {
                // Now you have the image, you can display it in an UIImageView
                DispatchQueue.main.async {
                    self.cardImageView.image = image
                    completion(nil)
                }
            }
        }
    }
}
