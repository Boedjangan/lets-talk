//
//  UserRepository.swft.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

protocol UserRepository {
    func createNewUser(newUser: UserEntity) -> UserEntity?
    func getUserDetails() -> UserEntity?
    func updateUserDetails(mutatedUser: UserEntity) -> UserEntity?
    func updateUserTalkDuration(newTalkDuration: Int) -> UserEntity?
    func updateCoupleID(coupleID: String) -> UserEntity?
}
