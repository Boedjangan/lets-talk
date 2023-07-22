//
//  UserService.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

class UserService {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func createNewUser(newUser: UserEntity) -> UserEntity? {
        return userRepository.createNewUser(newUser: newUser)
    }
    
    func getUserDetails() -> UserEntity? {
        return userRepository.getUserDetails()
    }
    
    func updateUserDetails(mutatedUser: UserEntity) -> UserEntity? {
        return userRepository.updateUserDetails(mutatedUser: mutatedUser)
    }
    
    func updateUserTalkDuration(newTalkDuration: Int) -> UserEntity? {
        return userRepository.updateUserTalkDuration(newTalkDuration: newTalkDuration)
    }
}
