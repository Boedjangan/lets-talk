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
    @Published var myRole: CoupleRole?
    
    private var userService = UserService(userRepository: UserCoreDataAdapter())
    
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
    func updateTalkDuration(newTalkDuration: Int) {
        if let newUserEntity = userService.updateUserTalkDuration(newTalkDuration: newTalkDuration) {
            user = newUserEntity
        }
    }
    
    func updateCouple(coupleID: String, coupleName: String){
        if let newUserEntity = userService.updateCouple(coupleID: coupleID, coupleName: coupleName) {
            user = newUserEntity
        }
    }
}
