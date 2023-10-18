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
    var todoCardImage: UIImage?
    private let views = TodoDetailsView()
    private(set) var viewModel = TodoDetailsVM()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
        setupTextFields()
    }
    
    // MARK: - Methods
    
    func setupSelf() {
        guard let todoCellVM = todoCellVM else {
            self.displayAlertMessage(title: "Error Loading Todo Details", message: "Todo Details could not be loaded")
            self.dismiss(animated: true)
            return
        }
        
        self.title = "Details"
        setupEditBarButton()
        views.setupCardViewDetails(todoCardCellVM: todoCellVM)
        if let todoCardImage = todoCardImage {
            self.views.cardImageView.image = todoCardImage
        }
        
        views.editImageViewButton.addTarget(self, action: #selector(todoImageViewPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func todoImageViewPressed(sender: UIImageView) {
        showImagePicker()
    }
    
    private func setupTextFields() {
        views.todoNameTextField.delegate = self
        views.todoDateTextField.delegate = self
        views.todoDescriptionTextField.delegate = self
        
        views.datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        views.todoDateTextField.inputView = views.datePicker
    }
    
    private func setupEditBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savedTapped))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        views.todoDateTextField.text = dateFormatter.string(from: sender.date)
        viewModel.updateTodoDate(date: sender.date)
        views.todoDateTextField.resignFirstResponder()
    }
    
    @objc func savedTapped() {
        guard var todoCellVM = todoCellVM else { return }
        
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
        
        todoCellVM.name = todoNameText
        todoCellVM.date = viewModel.todo.date
        todoCellVM.description = todoDescriptionText
        
        // Edit todo to the backendX
        viewModel.editTodoInFirebaseDB(todoCellVM: todoCellVM)
    }
    
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
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

extension TodoDetailsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Upload view image
            views.cardImageView.image = selectedImage
            
            saveImageData(selectedImage: selectedImage, picker: picker)
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    private func saveImageData(selectedImage: UIImage, picker: UIImagePickerController) {
        // Convert the selected image to Data
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            // Upload the image to Firebase Storage
            self.viewModel.imageData = imageData
        }
    }
}
