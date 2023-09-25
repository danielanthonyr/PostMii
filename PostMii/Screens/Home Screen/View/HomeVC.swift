//
//  HomeVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation
import UIKit
import Koloda

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
        setupKolodaView()
        setupViewModel()
    }
    
    func setupSelf() {
        self.title = "PostMii"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    func setupKolodaView() {
        views.kolodaView.delegate = self
        views.kolodaView.dataSource = self
    }
    
    func setupViewModel() {
        viewModel.reloadCollectionView = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                // Load tinder koloda cards here
                self.views.kolodaView.reloadData()
            }
        }
        viewModel.getTodos()
    }
    
    // MARK: - Methods
    
    @objc func addTapped() {
        // TODO: present modal todo card VC
        print("Add tapped")
    }
}

// MARK: - KolodaView

extension HomeVC: KolodaViewDelegate, KolodaViewDataSource {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return viewModel.todoCardCellVMs.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        // view to return
        let cellVM = viewModel.getTodoCellVM(at: index)
        
        let cardView = TodoCardView()
        cardView.cellVM = cellVM
        
        return cardView
    }
}

// MARK: - UICollectionView

//extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionViewRect = collectionView.frame
//
//        return CGSize(width: collectionViewRect.width, height: 160)
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.todoCardCellVMs.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let todoCellVM = viewModel.getTodoCellVM(at: indexPath)
//
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCardCell.reuseIdentifier, for: indexPath) as? TodoCardCell {
//            let layer = Gradients().allGradients[1]
//            layer.frame = cell.contentView.bounds
//
//            cell.layer.insertSublayer(layer, at: 0)
//            cell.layer.cornerRadius = 10
//            cell.layer.masksToBounds = true
//            cell.cellVM = todoCellVM
//            return cell
//        }
//
//        return UICollectionViewCell()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("item selected")
//    }
//}
