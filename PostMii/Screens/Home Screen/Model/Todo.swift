//
//  Card.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation

struct Todo: Identifiable, Decodable {
    var id: String?
    var name: String
    var description: String
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case date = "date"
    }
}
