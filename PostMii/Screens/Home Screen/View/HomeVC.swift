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
    }
    
    func setupViewModel() {
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCardCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .blue
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item selected")
    }
}
