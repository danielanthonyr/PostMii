//
//  TodoService.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-12.
//

import Foundation

protocol TodoServiceProtocol {
    func getTodos(completion: @escaping (Result<[TodoCard]?, Error>) -> Void)
}

class TodoService: TodoServiceProtocol {
    func getTodos(completion: @escaping (Result<[TodoCard]?, Error>) -> Void) {
        let cards: [TodoCard] = [
            TodoCard(name: "Do the dishes", description: "This todo is a todo that we must do the dishes damn i dont feel like it", date: Date()),
            TodoCard(name: "Mow the lawn", description: "This todo is a todo that we must mow the lawn, damn i don't feel like mowing the lawn", date: Date()),
            TodoCard(name: "Do math homework", description: "This todo is a todo that we must do our math homework, man i don't feel like doing my math homework", date: Date()),
            TodoCard(name: "Do the dishes", description: "This todo is a todo that we must do the dishes damn i dont feel like it", date: Date()),
            TodoCard(name: "Mow the lawn", description: "This todo is a todo that we must mow the lawn, damn i don't feel like mowing the lawn", date: Date()),
            TodoCard(name: "Do math homework", description: "This todo is a todo that we must do our math homework, man i don't feel like doing my math homework", date: Date())
        ]
        
        completion(.success(cards))
    }
    
}
