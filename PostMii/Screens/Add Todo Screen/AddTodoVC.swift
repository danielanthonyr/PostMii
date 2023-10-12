//
//  AddTodoVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation
import UIKit

class AddTodoVC: UIViewController {
    
    // MARK: - Variables
    
    private let views = AddTodoView()
    private let viewModel = AddTodoVM()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
        setupViewModel()
    }
    
    // MARK: - Methods
    
    private func setupSelf() {
        views.todoNameTextField.delegate = self
        views.todoDateTextField.delegate = self
        views.todoDescriptionTextField.delegate = self
        
        views.todoDateTextField.inputView = views.datePicker
        views.datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        views.createTodoButton.addTarget(self, action: #selector(createTodoButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private func setupViewModel() {
        viewModel.finishedSavingTodo = { [weak self] in
            guard let self = self else { return }
            
            self.dismiss(animated: true)
        }
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        views.todoDateTextField.text = dateFormatter.string(from: sender.date)
        viewModel.updateTodoDate(date: sender.date)
        views.todoDateTextField.resignFirstResponder()
    }
    
    @objc func createTodoButtonClicked(sender: UIButton) {
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
        viewModel.createTodoInFirebaseDB(name: todoNameText, description: todoDescriptionText)
    }
}

// MARK: - UITextFieldDelegate

extension AddTodoVC: UITextFieldDelegate {
    
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
