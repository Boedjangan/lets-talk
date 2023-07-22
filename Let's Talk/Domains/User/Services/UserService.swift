//
//  UserService.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

class UserService {
    private let userRepository: UserRepository
    
    init init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func createNewUser(newUser: UserEntity) -> UserEntity? {
        return self.createNewUser(newUser: newUser)
    }
    
    func getUserDetails() -> UserEntity? {
        return self.getUserDetails()
    }
    
    func updateUserDetails(username: String, gender: Gender, coupleId: String) -> UserEntity? {
        return self.updateUserDetails(username: username, gender: gender, coupleId: coupleId)
    }
    
    func updateUserTalkDuration(newTalkDuration: Int) -> UserEntity? {
        return self.updateUserTalkDuration(newTalkDuration: newTalkDuration)
    }
}
