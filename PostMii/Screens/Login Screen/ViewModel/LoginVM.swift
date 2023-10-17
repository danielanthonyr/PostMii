//
//  LoginVM.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-26.
//

import Foundation
import FirebaseAuth

class LoginVM {
    
    // MARK: - Variables
    
    var loginTriggered: (() -> Void)?
    
    private(set) var user: User
    private(set) var loginError: FirebaseAuthError?
    private let userAccountLoginService: UserAccountServiceProtocol
    
    // MARK: - Initializers
    
    init(service: UserAccountServiceProtocol = UserAccountService()) {
        self.user = User()
        self.userAccountLoginService = service
    }
    
    // MARK: - Methods
    
    func login(email: String, password: String) {
        loginError = nil
        let user = User(uid: nil, fullName: nil, email: email, password: password, profilePicURL: nil)
        
        userAccountLoginService.login(user: user) { result in
            switch result {
            case .success(let user):
                if let user = user {
                    self.user = User(
                        uid: user.uid,
                        fullName: user.fullName,
                        email: user.email,
                        password: "",
                        profilePicURL: user.profilePicURL
                    )
                }
                
            case .failure(let error):
                if let error = error as? FirebaseAuthError {
                    self.loginError = error
                }
            }
            
            self.loginTriggered?()
        }
    }
}
