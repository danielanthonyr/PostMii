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
