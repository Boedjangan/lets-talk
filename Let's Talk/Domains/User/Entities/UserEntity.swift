//
//  UserEntity.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

struct UserEntity: Identifiable {
    var id: UUID
    var username: String
    var gender: Gender
    var coupleId: String?
    var talkDuration: Int?
    var createdAt: Date
    var updatedAt: Date
}

