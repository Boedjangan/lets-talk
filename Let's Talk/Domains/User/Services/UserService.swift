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
    
    func updateUserDetails(mutatedUser: UserEntity) -> UserEntity? {
        return self.updateUserDetails(mutatedUser: mutatedUser)
    }
    
    func updateUserTalkDuration(newTalkDuration: Int) -> UserEntity? {
        return self.updateUserTalkDuration(newTalkDuration: newTalkDuration)
    }
}
