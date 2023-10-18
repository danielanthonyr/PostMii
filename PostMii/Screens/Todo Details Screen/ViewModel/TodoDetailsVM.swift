//
//  TodoDetailsVM.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-10-10.
//

import Foundation

class TodoDetailsVM {
    
    // MARK: - Variables
    
    var finishedEditingTodo: (() -> Void)?
    var imageData: Data?
    
    private let editTodoService: TodoServiceProtocol
    private(set) var todo: Todo
    private(set) var error: Error?
    
    // MARK: - Initializers
    
    init(service: TodoServiceProtocol = TodoService()) {
        self.editTodoService = service
        self.todo = Todo(timeStampId: "", name: "", description: "", date: Date())
    }
    
    // MARK: - Methods
    
    func editTodoInFirebaseDB(todoCellVM: TodoCardCellVM) {
        self.todo = Todo(
            timeStampId: todoCellVM.timeStampId,
            name: todoCellVM.name,
            description: todoCellVM.description,
            date: todoCellVM.date
        )
        
        if let imageData = self.imageData {
            editTodoService.updateTodoInFirebaseDBWithImage(todo: self.todo, imageData: imageData) { result in
                switch result {
                case .success(_):
                    self.finishedEditingTodo?()
                case .failure(let error):
                    self.error = error
                }
            }
            
        } else {
            editTodoService.updateTodoInFirebaseDB(todo: self.todo) { result in
                switch result {
                case .success(let saved):
                    if saved {
                        self.finishedEditingTodo?()
                    }
                    
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    func updateTodoDate(date: Date) {
        self.todo.date = date
    }
}
