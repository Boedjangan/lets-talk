//
//  UserEntity.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

struct UserEntity: Identifiable {
    var id: UUID = UUID()
    var username: String = ""
    var gender: Gender = .male
    var coupleId: String?
    var talkDuration: Int?
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}

