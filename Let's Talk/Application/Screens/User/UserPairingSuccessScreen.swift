//
//  UserPairingSuccessScreen.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

struct UserPairingSuccessScreen: View {
    var body: some View {
        VStack{
            
            Text("🎉Selamat🎉")
                .foregroundColor(Color.white)
                .font(Font.avatarIcon)
                .padding(.top,40)
                .padding(.bottom,50)
            Text("Kamu telah terkoneksi dengan pasanganmu ")
                .foregroundColor(Color.white)
                .padding(.bottom,50)
            HStack(){
                AvatarView(userName: "Ethan")
                AvatarView(userName: "Anne")
            }
            Spacer()
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.background)
    }
}

struct UserPairingSuccessScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserPairingSuccessScreen()
    }
}
