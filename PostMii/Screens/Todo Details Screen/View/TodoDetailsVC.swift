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
        setupViewModel()
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
    
    func setupViewModel() {
        
    }
    
    private func setupTextFields() {
        views.todoNameTextField.delegate = self
        views.todoDateTextField.delegate = self
        views.todoDescriptionTextField.delegate = self
    }
    
    private func setupEditBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savedTapped))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: - Methods
    
    // TODO: Figure out what to do with this edit bar button item if wanna show another VC or edit in place
    @objc func savedTapped() {
        guard let todoCellVM = todoCellVM else { return }
        
        guard let todoNameText = views.todoNameTextField.text, !todoNameText.isEmpty else {
            self.displayAlertMessage(title: "Missing Name", message: "Please fill out the Todo Name field")
            return
        }
        
        guard let todoDateText = views.todoDateTextField.text, !todoDateText.isEmpty else {
            self.displayAlertMessage(title: "Missing Date", message: "Please fill out the Todo Date field")
            return
        }
        
        guard let todoDescriptionText = views.todoDescriptionTextField.text, !todoDescriptionText.isEmpty else {
            self.displayAlertMessage(title: "Missing Description", message: "Please fill out the Todo Description field")
            return
        }
        
        // Add todo to the backend
        //viewModel.saveTodoToFirebase(name: todoNameText, description: todoDescriptionText, date: viewModel.todo.date)
        
        self.dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension TodoDetailsVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case views.todoNameTextField:
            views.todoDateTextField.becomeFirstResponder()
        case views.todoDateTextField:
            views.todoDescriptionTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}
