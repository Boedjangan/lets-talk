//
//  UserRepository.swft.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

protocol UserRepository {
    func getUserDetails() -> UserEntity?
    func updateUserDetails() -> UserEntity?
    func updateUserTalkDuration() -> UserEntity?
}
