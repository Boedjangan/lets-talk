//
//  UserViewModel.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

//TODO: Still need to implement more logic, will update as we go with integration
@MainActor
class UserViewModel: ObservableObject {
    @Published var user: UserEntity = UserEntity()
    
    private var userService = UserService(userRepository: CoreDataAdapter())
    
    init() {
       initializeUser()
    }
    
    private func initializeUser() {
        guard let userDetails = userService.getUserDetails() else {
            userService.createNewUser(newUser: user)
            
            return
        }
        
        user = userDetails
    }
    
    // TODO: Handle error on return nil
    func updateUserDetails() {
        userService.updateUserDetails(mutatedUser: user)
    }
    
    // TODO: Handle error on return nil
    func updateTalkDuration() {
        userService.updateUserTalkDuration(newTalkDuration: user.talkDuration ?? 0)
    }
    
    func updateCouple(coupleID:String,coupleName:String){
        userService.updateCouple(coupleID: coupleID, coupleName: coupleName)
    }
}
