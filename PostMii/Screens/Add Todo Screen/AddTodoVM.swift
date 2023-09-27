//
//  AddTodoVM.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation
import Firebase

class AddTodoVM {
    
    // MARK: - Variables
    
    var finishedSavingTodo: (() -> Void)?
    
    private let addTodoService: TodoServiceProtocol
    private(set) var todo: Todo
    
    // MARK: - Initializers
    
    init(service: TodoServiceProtocol = TodoService()) {
        self.addTodoService = service
        self.todo = Todo(name: "", description: "", date: Date())
    }
    
    
    // MARK: - Methods
    
    
    func saveTodoToFirebase(name: String, description: String, date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        
        self.todo = Todo(name: name, description: description, date: todo.date)
        let formattedStringDate = dateFormatter.string(from: date)
        
        let ref = Database.database().reference()
        let key = ref.child("todoList").childByAutoId().key
        
        let dictionaryTodo = [ "name"    : todo.name ,
                               "date" : formattedStringDate,
                               "description"    : todo.description ]
        
        let childUpdates = ["/todoList/\(key)": dictionaryTodo]
        ref.updateChildValues(childUpdates, withCompletionBlock: { (error, ref) -> Void in
            if let error = error {
                print("error saving todo to DB")
                return
            }
            self.finishedSavingTodo?()
        })
    }
    
    func updateTodoDate(date: Date) {
        self.todo.date = date
    }
}
