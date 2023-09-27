//
//  TodoService.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-12.
//

import Foundation
import Firebase

protocol TodoServiceProtocol {
    func getTodos(completion: @escaping (Result<[Todo]?, Error>) -> Void)
    func createTodo(completion: @escaping (Result<Todo?, Error>) -> Void)
}

class TodoService: TodoServiceProtocol {
    func getTodos(completion: @escaping (Result<[Todo]?, Error>) -> Void) {
        var todos = [Todo]()
        
        
        
        
        completion(.success(todos))
    }
    
    func createTodo(completion: @escaping (Result<Todo?, Error>) -> Void) {
        let todo = Todo(name: "1", description: "111", date: Date())
        completion(.success(todo))
    }
}
