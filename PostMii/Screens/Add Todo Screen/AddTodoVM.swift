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
        self.todo = Todo(timeStampId: "", name: "", description: "", date: Date())
    }
    
    
    // MARK: - Methods
    
    
    func saveTodoToFirebase(name: String, description: String, date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        
        let timeStamp = "\(Int(NSDate.timeIntervalSinceReferenceDate*1000))"
        self.todo = Todo(timeStampId:timeStamp, name: name, description: description, date: todo.date)
        let formattedStringDate = dateFormatter.string(from: date)
        
        if let user = Auth.auth().currentUser {
            
            let userUID = user.uid
            
            // Create a reference to the Firebase Realtime Database
            let databaseReference = Database.database().reference()
            
            let todoData = [
                "timeStampId" : todo.timeStampId,
                "name"    : todo.name ,
                "date" : formattedStringDate,
                "description"    : todo.description ]
            
            databaseReference.child("users").child(userUID).child("todos").child(timeStamp).setValue(todoData) { (error, reference) in
                if let error = error {
                    // Handle the error if it occurs
                    print("Error adding todo: \(error.localizedDescription)")
                } else {
                    // Todo added successfully
                    print("Todo added to Firebase Database")
                }
            }
            
        } else {
            print("User is not authenticated")
        }
    }
    
    func updateTodoDate(date: Date) {
        self.todo.date = date
    }
}
