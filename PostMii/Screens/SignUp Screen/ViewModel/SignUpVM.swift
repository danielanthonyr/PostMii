//
//  SignUpVM.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-27.
//

import Foundation

class SignUpVM {
    
    // MARK: - Variables
    
    var accountCreated: (() -> Void)?
    
    // MARK: - Inits
    
    private(set) var user: User
    private(set) var accountCreatedError: FirebaseAuthError?
    private let userAccountCreationService: UserAccountServiceProtocol
    
    // MARK: - Methods
    
    init(service: UserAccountServiceProtocol = UserAccountService()) {
        self.user = User()
        self.userAccountCreationService = service
    }
    
    func createAccount(withFullname: String, withEmail: String, withPassword: String) {
        accountCreatedError = nil // in case user made an error, won't reshow error dialog
        let user = User(fullName: withFullname, email: withEmail, password: withEmail, profilePicURL: nil)
        
        userAccountCreationService.createUser(user: user) { result in
            switch result {
            case .success(let user):
                if let user = user?.user, let uid = user.uid {
                    self.user = User(
                        uid: uid, fullName:
                            user.fullName,
                        email: user.email,
                        password: user.password,
                        profilePicURL: user.profilePicURL
                    )
                }
                
            case .failure(let error):
                if let error = error as? FirebaseAuthError {
                    self.accountCreatedError = error
                }
            }
            
            self.accountCreated?()
        }
    }
}
