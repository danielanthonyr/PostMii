//
//  MyProfileVM.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-25.
//

import Foundation
import Firebase

class MyProfileVM {
    
    // MARK: - Variables
    
    var loadUserProfilePage: (() -> Void)?
    var myProfile: MyProfile
    private let myProfileService: MyProfileServiceProtocol
    private(set) var getMyProfileError: FirebaseError?
    
    // var myProfile: MyProfile
    
    
    // MARK: - Init
    
    init(myProfileService: MyProfileServiceProtocol = MyProfileService()) {
        self.myProfileService = myProfileService
        self.myProfile = MyProfile()
    }
    
    // MARK: - Methods
    
    func getMyProfile() {
        myProfileService.getMyProfile { result in
            switch result {
            case .success(let myProfile):
                if let myProfile = myProfile {
                    self.myProfile = myProfile
                }
            case .failure(let error):
                self.getMyProfileError = FirebaseError.message(error.localizedDescription)
            
            }
            
            self.loadUserProfilePage?()
        }
    }
}
