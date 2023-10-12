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
        setupCalendarView()
        setupKolodaView()
        setupViewModel()
    }
    
    func setupSelf() {
//        self.title = "PostMii"
        self.title = "Home"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    private func setupKolodaView() {
        views.kolodaView.delegate = self
        views.kolodaView.dataSource = self
    }
    
    private func setupCalendarView() {
        views.calendarView.setupDateLabel(with: Date())
    }
    
    private func setupViewModel() {
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
        let AddTodoVC = AddTodoVC()
        self.present(AddTodoVC, animated: true, completion: nil)
    }
}

// MARK: - KolodaView

extension HomeVC: KolodaViewDelegate, KolodaViewDataSource {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        DispatchQueue.main.async {
            koloda.reloadData()
        }
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        // user clicked on card, present todo details
        let cellVM = viewModel.getTodoCellVM(at: index)
        
        let todoDetailsVC = TodoDetailsVC()
        todoDetailsVC.todoCellVM = cellVM
        navigationController?.pushViewController(todoDetailsVC, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == SwipeResultDirection.right {
            // user completed todo, delete from firebase db
            let todo = viewModel.getTodoCellVM(at: index)
            viewModel.markTodoAsCompleted(todo: todo)
        } else if direction == SwipeResultDirection.left {
            // user postpone todo, move card to end of stack
            // TODO: Figure out what we wanna do when user swipes left on a todo
            print("User swiped left")
        }
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
