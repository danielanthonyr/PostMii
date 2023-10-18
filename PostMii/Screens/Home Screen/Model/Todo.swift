//
//  Card.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation

struct Todo: Decodable {
    var timeStampId: String
    var todoPhotoURL: String?
    var name: String
    var description: String
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case timeStampId = "timeStampId"
        case todoPhotoURL = "todoPhotoURL"
        case name = "name"
        case description = "description"
        case date = "date"
    }
}
