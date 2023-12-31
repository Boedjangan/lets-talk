//
//  UserCoreDataAdapter.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation
import CoreData

class UserCoreDataAdapter: UserRepository {
    private let coreDataContext = CoreDataConnection.shared.managedObjectContext
    
    func createNewUser(newUser: UserEntity) -> UserEntity? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        
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
        user.gender = Int16(newUser.gender.rawValue)
        user.coupleId = newUser.coupleId
        user.coupleName = newUser.coupleName
        user.talkDuration = Int64(newUser.talkDuration ?? 0)
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
                id: user.id.unsafelyUnwrapped,
                username: user.username.unsafelyUnwrapped,
                gender: Gender(rawValue: user.gender.toInt) ?? .male,
                coupleId: user.coupleId ?? "",
                coupleName: user.coupleName ?? "",
                talkDuration: user.talkDuration.toInt,
                createdAt: user.createdAt.unsafelyUnwrapped,
                updatedAt: user.updatedAt.unsafelyUnwrapped
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
            user.gender = mutatedUser.gender.rawValue.toInt16
            user.coupleId = mutatedUser.coupleId ?? user.coupleId
            user.coupleName = mutatedUser.coupleName ?? user.coupleName
            user.updatedAt = Date()
            
            try coreDataContext.save()
            
            return UserEntity(
                id: user.id.unsafelyUnwrapped,
                username: user.username.unsafelyUnwrapped,
                gender: Gender(rawValue: user.gender.toInt) ?? .male,
                coupleId: user.coupleId ?? "",
                coupleName: user.coupleName ?? "",
                talkDuration: user.talkDuration.toInt,
                createdAt: user.createdAt.unsafelyUnwrapped,
                updatedAt: user.updatedAt.unsafelyUnwrapped
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
            
            user.talkDuration = newTalkDuration.toInt64
            user.updatedAt = Date()
            
            try coreDataContext.save()
            
            return UserEntity(
                id: user.id.unsafelyUnwrapped,
                username: user.username.unsafelyUnwrapped,
                gender: Gender(rawValue: user.gender.toInt) ?? .male,
                coupleId: user.coupleId ?? "",
                coupleName: user.coupleName ?? "",
                talkDuration: user.talkDuration.toInt,
                createdAt: user.createdAt.unsafelyUnwrapped,
                updatedAt: user.updatedAt.unsafelyUnwrapped
            )
        } catch {
            print("Failed updating user talk duration")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func updateCouple(coupleID: String, coupleName: String) -> UserEntity? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try coreDataContext.fetch(request)
            
            guard let user = users.first else {
                return nil
            }
            
            user.coupleId = coupleID
            user.coupleName = coupleName
            user.updatedAt = Date()
            
            try coreDataContext.save()
            
            return UserEntity(
                id: user.id.unsafelyUnwrapped,
                username: user.username.unsafelyUnwrapped,
                gender: Gender(rawValue: user.gender.toInt) ?? .male,
                coupleId: user.coupleId ?? "",
                coupleName: user.coupleName ?? "",
                talkDuration: user.talkDuration.toInt,
                createdAt: user.createdAt.unsafelyUnwrapped,
                updatedAt: user.updatedAt.unsafelyUnwrapped
            )
        } catch {
            print("Failed updating user details")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
}
