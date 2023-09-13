//
//  HomeVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Variables
    
    private let views = HomeView()
    private let viewModel = HomeVM()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
        setupTodoCollectionView()
        setupViewModel()
    }
    
    func setupSelf() {
        self.title = "PostMii"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    func setupTodoCollectionView() {
        views.todoCollectionView.delegate = self
        views.todoCollectionView.dataSource = self
        views.todoCollectionView.register(TodoCardCell.self, forCellWithReuseIdentifier: TodoCardCell.reuseIdentifier)
    }
    
    func setupViewModel() {
        viewModel.getTodos()
        viewModel.reloadCollectionView = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.views.todoCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - Methods
    
    @objc func addTapped() {
        // TODO: present modal todo card VC
        print("Add tapped")
    }
}

// MARK: - UICollectionView

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewRect = collectionView.frame
        
        return CGSize(width: collectionViewRect.width, height: 160)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.todoCardCellVMs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let todoCellVM = viewModel.getTodoCellVM(at: indexPath)
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCardCell.reuseIdentifier, for: indexPath) as? TodoCardCell {
            let layer = Gradients().allGradients[1]
            layer.frame = cell.contentView.bounds
            
            cell.layer.insertSublayer(layer, at: 0)
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            cell.cellVM = todoCellVM
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item selected")
    }
}
