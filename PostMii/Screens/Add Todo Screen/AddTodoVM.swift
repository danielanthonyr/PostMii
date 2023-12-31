//
//  AddTodoVM.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation

class AddTodoVM {
    
    // MARK: - Variables
    
    var finishedSavingTodo: (() -> Void)?
    var imageData: Data?
    
    private let addTodoService: TodoServiceProtocol
    private(set) var todo: Todo
    private(set) var error: Error?
    
    // MARK: - Initializers
    
    init(service: TodoServiceProtocol = TodoService()) {
        self.addTodoService = service
        self.todo = Todo(timeStampId: "", name: "", description: "", date: Date())
    }
    
    
    // MARK: - Methods
    
    func createTodoInFirebaseDB(name: String, description: String) {
        let timeStamp = "\(Int(NSDate.timeIntervalSinceReferenceDate*1000))"
        self.todo = Todo(timeStampId: timeStamp, name: name, description: description, date: todo.date)
        
        if let imageData = self.imageData {
            addTodoService.updateTodoInFirebaseDBWithImage(todo: self.todo, imageData: imageData) { result in
                switch result {
                case .success(_):
                    self.finishedSavingTodo?()
                case .failure(let error):
                    self.error = error
                }
            }
            
        } else {
            addTodoService.updateTodoInFirebaseDB(todo: self.todo) { result in
                switch result {
                case .success(let saved):
                    if saved {
                        self.finishedSavingTodo?()
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
