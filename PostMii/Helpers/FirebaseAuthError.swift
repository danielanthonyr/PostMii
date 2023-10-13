//
//  FirebaseAuthError.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-10-13.
//

import Foundation
import FirebaseAuth

enum FirebaseAuthError: Error {
    case operationNotAllowedError(title: String, message: String)
    case emailAlreadyInUseError(title: String, message: String)
    case invalidEmail(title: String, message: String)
    case weakPassword(title: String, message: String)
    case defaultError(title: String, message: String)
    
    var localizedDescription: (title: String, message: String) {
        switch self {
        case .operationNotAllowedError(let title, let message):
            return (title: title, message: message)
        case .emailAlreadyInUseError(let title, let message):
            return (title: title, message: message)
        case .invalidEmail(let title, let message):
            return (title: title, message: message)
        case .weakPassword(let title, let message):
            return (title: title, message: message)
        case .defaultError(let title, let message):
            return (title: title, message: message)
        }
    }
}
