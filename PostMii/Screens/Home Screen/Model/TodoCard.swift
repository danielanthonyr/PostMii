//
//  Card.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation

struct TodoCard: Identifiable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var date: Date
}

var cards: [TodoCard] = [
    TodoCard(name: "Do the dishes", description: "This todo is a todo that we must do the dishes damn i dont feel like it", date: Date()),
    TodoCard(name: "Mow the lawn", description: "This todo is a todo that we must mow the lawn, damn i don't feel like mowing the lawn", date: Date()),
    TodoCard(name: "Do math homework", description: "This todo is a todo that we must do our math homework, man i don't feel like doing my math homework", date: Date())
]
