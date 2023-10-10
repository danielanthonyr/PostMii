//
//  MyProfileService.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-10-09.
//

import Foundation
import Firebase

protocol MyProfileServiceProtocol {
    func getMyProfile(completion: @escaping (Result<MyProfile?, Error>) -> Void)
}

class MyProfileService: MyProfileServiceProtocol {
    func getMyProfile(completion: @escaping (Result<MyProfile?, Error>) -> Void) {
        var myProfile = MyProfile(fullName: "", email: "")
        
        if let user = Auth.auth().currentUser {
            myProfile.fullName = user.displayName
            myProfile.email = user.email
            myProfile.profilePicURL = user.photoURL
            
            completion(.success(myProfile))
        } else {
            let errorMessage = "Error fetching user profile"
            let error = FirebaseError.message(errorMessage)
            
            completion(.failure(error))
        }
    }

}
