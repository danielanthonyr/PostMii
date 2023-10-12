//
//  TodoDetailsVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-10-10.
//

import Foundation
import UIKit

class TodoDetailsVC: UIViewController {
    
    // MARK: - Variables
    
    var todoCellVM: TodoCardCellVM?
    private let views = TodoDetailsView()
    private let viewModel = TodoDetailsVM()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
    }
    
    func setupSelf() {
        guard let todoCellVM = todoCellVM else {
            self.displayAlertMessage(title: "Error Loading Todo Details", message: "Todo Details could not be loaded")
            self.dismiss(animated: true)
            return
        }
        
        self.title = "Details"
        setupEditBarButton()
        views.setupCardViewDetails(todoCardCellVM: todoCellVM)
    }
    
    private func setupEditBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: - Methods
    
    @objc func editTapped() {
        // TODO: present modal todo card VC
        guard let todoCellVM = todoCellVM else { return }
        
//        let editTodoVC = EditTodoVC()
//        editTodoVC.todoCellVM = todoCellVM
//        present(editTodoVC, animated: true)
    }
}
