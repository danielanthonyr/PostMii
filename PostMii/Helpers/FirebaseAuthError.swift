//
//  FirebaseAuthError.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-10-13.
//

import Foundation
import FirebaseAuth

enum FirebaseAuthError: Error {
    // Sign Up Errors
    case operationNotAllowedError(title: String, message: String)
    case emailAlreadyInUseError(title: String, message: String)
    case invalidEmail(title: String, message: String)
    case weakPassword(title: String, message: String)
    case defaultError(title: String, message: String)
    
    // Login Errors
    case invalidPassword(title: String, message: String)
    case invalidSignInEmail(title: String, message: String)
    case userNotFound(title: String, message: String)
    case networkError(title: String, message: String)
    case noUserIdError(title: String, message: String)
    case defaultSignInError(title: String, message: String)
    
    var localizedDescription: (title: String, message: String) {
        switch self {
            // Sign Up
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
        
            // Sign In
        case .invalidPassword(let title, let message):
            return (title: title, message: message)
        case .invalidSignInEmail(let title, let message):
            return (title: title, message: message)
        case .userNotFound(let title, let message):
            return (title: title, message: message)
        case .networkError(let title, let message):
            return (title: title, message: message)
        case .noUserIdError(title: let title, message: let message):
            return (title: title, message: message)
        case .defaultSignInError(let title, let message):
            return (title: title, message: message)
        }
    }
}
