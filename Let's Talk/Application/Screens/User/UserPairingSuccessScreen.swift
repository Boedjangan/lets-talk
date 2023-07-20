//
//  UserPairingSuccessScreen.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

struct UserPairingSuccessScreen: View {
    var maleName : String = "male"
    var femaleName : String = "female"
    
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
            HStack(){
                AvatarView(userName: maleName)
                AvatarView(userName: femaleName)
            }
            Spacer()
            ButtonView(){
                
            }label:{
                Text("Next")
            }
            .buttonStyle(.primary)
            .padding(.bottom,36)
        }
    }
}

struct UserPairingSuccessScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserPairingSuccessScreen(maleName: "Ethan",femaleName: "Anne")
    }
}
