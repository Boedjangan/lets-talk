//
//  CoreDataAdapter.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation
import CoreData

class CoreDataAdapter: UserRepository {
    private let coreDataContext = CoreDataConnection.shared.managedObjectContext
    
    func createNewUser(newUser: UserEntity) -> UserEntity? {
        do {
            let users = try coreDataContext.fetch(request)
            
            if users.isNotEmpty {
                print("User already exist, can not create a new one!")
                
                return nil
            }
        } catch {
            print("Failed checking if user already exist!")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
        
        let user = User(context: coreDataContext)
        
        user.id = newUser.id
        user.username = newUser.username
        user.gender = newUser.gender.rawValue
        user.coupleId = newUser.coupleId
        user.talkDuration = newUser.talkDuration
        user.createdAt = newUser.createdAt
        user.updatedAt = newUser.updatedAt
        
        do {
            try coreDataContext.save()
            
            return newUser
        } catch {
            print("Failed creating new user")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func getUserDetails() -> UserEntity? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try coreDataContext.fetch(request)
            
            guard let user = users.first else {
                return nil
            }
            
            return UserEntity(
                id: user.id,
                username: user.username,
                gender: Gender(rawValue: user.gender),
                coupleId: user.coupleId ?? "",
                talkDuration: user.talkDuration,
                createdAt: user.createdAt,
                updatedAt: user.updatedAt
            )
        } catch {
            print("Failed getting user details")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func updateUserDetails(mutatedUser: UserEntity) -> UserEntity? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try coreDataContext.fetch(request)
            
            guard let user = users.first else {
                return nil
            }
            
            user.username = mutatedUser.username
            user.gender = mutatedUser.gender.rawValue
            user.coupleId = mutatedUser.coupleId ?? user.coupleId
            user.updatedAt = Date()
            
            try coreDataContext.save()
            
            return UserEntity(
                id: user.id,
                username: user.username,
                gender: Gender(rawValue: user.gender),
                coupleId: user.coupleId ?? "",
                talkDuration: user.talkDuration,
                createdAt: user.createdAt,
                updatedAt: user.updatedAt
            )
        } catch {
            print("Failed updating user details")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func updateUserTalkDuration(newTalkDuration: Int) -> UserEntity? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try coreDataContext.fetch(request)
            
            guard let user = users.first else {
                return nil
            }
            
            user.talkDuration = newTalkDuration
            user.updatedAt = Date()
            
            try coreDataContext.save()
            
            return UserEntity(
                id: user.id,
                username: user.username,
                gender: Gender(rawValue: user.gender),
                coupleId: user.coupleId ?? "",
                talkDuration: user.talkDuration,
                createdAt: user.createdAt,
                updatedAt: user.updatedAt
            )
        } catch {
            print("Failed updating user talk duration")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
}
