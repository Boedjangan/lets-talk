//
//  UserPairingSuccessScreen.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

struct UserPairingSuccessScreen: View {
    @AppStorage("onboarding") var onboarding: String = OnboardingRoutes.welcome.rawValue
    @ObservedObject var userVM:UserViewModel
    
    var userName: String
    var coupleName: String
    var gender:String
    
    init(userVM: UserViewModel) {
        self.userVM = userVM
        self.userName = userVM.user.username
        self.coupleName = userVM.user.coupleName ?? "couple"
        if userVM.user.gender == .male {
            self.gender = "Male"
        }else{
            self.gender = "Female"
        }
    }
    
    var body: some View {
        LayoutView{
            Text("🎉Selamat🎉")
                .foregroundColor(Color.white)
                .font(Font.avatarIcon)
                .padding(.top,38)
                .padding(.bottom,38)
            
            Text("Kamu telah terhubung dengan pasanganmu ")
                .foregroundColor(Color.white)
                .padding(.bottom,78)
            
            HStack() {
                AvatarView(userName: userName,iconImage: gender)
                AvatarView(userName: coupleName,iconImage: gender)
            }
            Spacer()
            
            ButtonView() {
                onboarding = OnboardingRoutes.done.rawValue
            } label: {
                Text("Next")
            }
            .buttonStyle(.fill())
            .padding(.bottom,36)
        }
    }
}

//struct UserPairingSuccessScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        UserPairingSuccessScreen()
//    }
//}
