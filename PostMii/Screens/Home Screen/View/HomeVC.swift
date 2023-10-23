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
    
    // MARK: - Methods
    
    func setupSelf() {
//        self.title = "PostMii"
        self.title = "Home"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.views.emptyTodoCardDeckView.reloadButton.addTarget(self, action: #selector(emptyViewReloadButtonPressed(sender:)), for: .touchUpInside)
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
    
    @objc func addTapped() {
        let addTodoVC = AddTodoVC()
        addTodoVC.viewModel.finishedSavingTodo = { [weak self] in
            guard let self = self else { return }
            
            navigationController?.dismiss(animated: true)
            viewModel.getTodos()
        }
        self.present(addTodoVC, animated: true, completion: nil)
    }
    
    @objc func emptyViewReloadButtonPressed(sender: UIButton) {
        DispatchQueue.main.async {
            self.views.emptyTodoCardDeckView.isHidden = true
        }
        self.viewModel.getTodos()
    }
}

// MARK: - KolodaView

extension HomeVC: KolodaViewDelegate, KolodaViewDataSource {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        DispatchQueue.main.async {
            self.views.emptyTodoCardDeckView.isHidden = false
        }
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        // user clicked on card, present todo details
        let cellVM = viewModel.getTodoCellVM(at: index)
        
        let todoDetailsVC = TodoDetailsVC()
        todoDetailsVC.todoCellVM = cellVM
        
        // passing the todo card image dynamically to avoid unnecessary API calls
        if let imageURL = cellVM.todoPhotoURL, imageURL != "", let todoCardView = koloda.viewForCard(at: index) as? TodoCardView {
            todoDetailsVC.todoCardImage = todoCardView.cardImageView.image
        }
        
        todoDetailsVC.viewModel.finishedEditingTodo = { [weak self] in
            guard let self = self else { return }
            
            self.navigationController?.popViewController(animated: true)
            viewModel.getTodos()
        }
        
        navigationController?.pushViewController(todoDetailsVC, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == SwipeResultDirection.right {
            // user completed todo, delete from firebase db
            let todo = viewModel.getTodoCellVM(at: index)
            viewModel.markTodoAsCompleted(todo: todo)
        } else if direction == SwipeResultDirection.left {
            // user postpone todo, move card to end of stack
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
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        let overlayView = TodoCardOverlayView()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.clipsToBounds = true
        
        return overlayView
    }
}
