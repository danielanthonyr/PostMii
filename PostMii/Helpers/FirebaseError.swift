//
//  FirebaseError.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-27.
//

import Foundation

enum FirebaseError: Error {
    case accountCreationError((title: String, message: String))
    case message(String)
}
