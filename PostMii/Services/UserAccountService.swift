//
//  UserAccountService.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-10-13.
//

import Foundation
import FirebaseAuth

protocol UserAccountServiceProtocol {
    func createUser(user: User, completion: @escaping (Result<(user: User, uid: String)?, Error>) -> Void)
}

class UserAccountService: UserAccountServiceProtocol {
    func createUser(user: User, completion: @escaping (Result<(user: User, uid: String)?, Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email!, password: user.password!) { authResult, error in
            
            if let error = error {
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.operationNotAllowed.rawValue:
                    let error = FirebaseAuthError.operationNotAllowedError(
                        title: "Operation Not Allowed",
                        message: "Sign Up service is disabled"
                    )
                    completion(.failure(error))
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    let error = FirebaseAuthError.emailAlreadyInUseError(
                        title: "Email Already in use",
                        message: "Email is already in use"
                    )
                    completion(.failure(error))
                case AuthErrorCode.invalidEmail.rawValue:
                    let error = FirebaseAuthError.invalidEmail(
                        title: "Invalid Email",
                        message: "Invalid Email. Please enter a valid email"
                    )
                    completion(.failure(error))
                case AuthErrorCode.weakPassword.rawValue:
                    let error = FirebaseAuthError.weakPassword(
                        title: "Weak Password",
                        message: "Weak Password. Please choose a better password"
                    )
                    completion(.failure(error))
                default:
                    let error = FirebaseAuthError.defaultError(
                        title: "Sign Up Error",
                        message: "Sign up error. Please report to development team"
                    )
                    completion(.failure(error))
                }
            }
            
            /*
             For future feature where user uploads profile pic, see here
             https://stackoverflow.com/questions/38389341/firebase-create-user-with-email-password-display-name-and-photo-url#:~:text=I%20think%20this%20should%20solve%20it%20for%20you%2C%20let%20me%20know%20if%20you%20need%20anything%20else.%20or%20have%20any%20further%20questions%20on%20this%20matter.
             */
            
            // Adding display name to firebase acc creation
            if let authenticatedUser = authResult?.user {
                let changeRequest = authenticatedUser.createProfileChangeRequest()
                changeRequest.displayName = user.fullName
                
                changeRequest.commitChanges { error in
                    if error != nil {
                        guard let message = error?.localizedDescription else { return }
                        let firebaseError = FirebaseError.accountCreationError((
                            title: "Account Creation Error",
                            message: message
                        ))
                        completion(.failure(firebaseError))
                        return
                    }
                }
                
                completion(.success((user: user, uid: authenticatedUser.uid)))
            }
        }
    }
}
