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
            // show error message
            showTextFieldValidationError(with: "Todo Name")
            return
        }
        
        guard let todoDateText = views.todoDateTextField.text, !todoDateText.isEmpty else {
            showTextFieldValidationError(with: "Todo Date")
            return
        }
        
        guard let todoDescriptionText = views.todoDescriptionTextField.text, !todoDescriptionText.isEmpty else {
            showTextFieldValidationError(with: "Todo Description")
            return
        }
        
        // Add todo to the backend
        viewModel.saveTodoToFirebase(name: todoNameText, description: todoDescriptionText, date: viewModel.todo.date)
        
        self.dismiss(animated: true)
    }
    
    func showTextFieldValidationError(with string: String) {
        // create the alert
        let alert = UIAlertController(title: "Missing Entry", message: "Please fill out the \(string) field.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
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
