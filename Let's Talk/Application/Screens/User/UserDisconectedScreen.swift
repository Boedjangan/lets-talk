//
//  UserDisconectedScreen.swift
//  Let's Talk
//
//  Created by Elwin Johan Sibarani on 26/07/23.
//

import SwiftUI

struct UserDisconectedScreen: View {
    @AppStorage("onboarding") var onboarding: String = OnboardingRoutes.welcome.rawValue
    
    var isDisconnected: Bool = false
    var captionDisconnected: String = "Opps, koneksi perangkat kalian terputus. Silahkan sambungkan ulang dan mulai kembali ya."
    var captionNotConnected: String = "Opps, kamu belum tersambung dengan pasangan kamu. Ayo hubungkan dengan pasangan kamu untuk mulai"
    
    var body: some View {
        LayoutView{
            Text(isDisconnected ? captionDisconnected : captionNotConnected)
                .foregroundColor(Color.white)
                .padding(.bottom,78)
                .multilineTextAlignment(.center)
            
            HStack(spacing: -15){
                AvatarView(iconImage: "Male", isDisabled: true)
                AvatarView(iconImage: "Female", isDisabled: true)
            }
            .padding(.bottom, 50)
            
            if(isDisconnected){
                Text("Untuk menghindari terputus koneksi saat bermain pastikan hal-hal berikut: \n • Pastikan jarak antar perangkat tidak lebih dari 8 meter \n • Pastikan Bluetooth dan jaringan WiFi tetap aktif")
                    .foregroundColor(Color.white)
                    .padding(.bottom,78)
                    .multilineTextAlignment(.center)
                    .font(.subQuestion)
                Spacer()
                
                ButtonView() {
                    onboarding = OnboardingRoutes.setup.rawValue
                } label: {
                    Text("Hubungkan")
                }
                .buttonStyle(.fill())
                .padding(.bottom,36)
                
            }else{
                Text("Mohon menunggu \n Sedang mencari perangkat pasanganmu. . .")
                    .font(.genderPickerLabel)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
    }
}

struct UserDisconectedScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserDisconectedScreen()
    }
}
