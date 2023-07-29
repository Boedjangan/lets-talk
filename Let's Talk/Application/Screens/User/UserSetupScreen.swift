//
//  UserSetupScreen.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

struct UserSetupScreen: View {
    @AppStorage("onboarding") var onboarding: String = OnboardingRoutes.welcome.rawValue
    @ObservedObject var userVM: UserViewModel
    @ObservedObject var multipeerHandler: MultipeerHandler
    
    @State private var isError: Bool = false
    var errorMessage: String = "Silahkan isi ini terlebih dahulu"
    
    var body: some View {
        LayoutView() {
            ScrollView {
                VStack(spacing: 8) {
                    Spacer()
                    
                    AppLogoView()
                    
                    Spacer()
                    
                    Text("Bantu kami lebih mengenal kamu")
                    Text("Siapa nama panggilan kamu?")
                        .font(.heading)
                        .padding(.bottom, 50)
                    
                    VStack(alignment: .leading){
                        TextField("Username",text: $userVM.user.username, prompt: Text("Sebutkan namamu")
                            .foregroundColor(.white))
                            .multilineTextAlignment(.center)
                            .overlay(Divider().background(isError ? .red : .white).offset(y: 5), alignment: .bottom)
                            
                        if(isError){
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.subQuestion)
                                .padding(.top, 5)
                        }
                    }
                    .padding(.bottom, 50)
                    
                    
                    GenderSelectorView(gender: $userVM.user.gender)
                        .padding(.bottom, 50)
                    
                    Spacer()
                    
                    ButtonView {
                        if (userVM.user.username.count == 0) {
                            isError = true
                        } else {
                            // User simpan username dan gender
                            userVM.updateUserDetails()
                            
                            // User simpan username dia di multipeer buat disend ke pasangan
                            multipeerHandler.username = userVM.user.username
                            
                            // Pindah screen ke pairing
                            onboarding = OnboardingRoutes.pairing.rawValue
                        }
                    } label: {
                        Text("Selanjutnya")
                    }
                    .buttonStyle(.fill())
                }
            }
        }
    }
}

struct UserSetupScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(UserViewModel()) { userVM in
            StatefulObjectPreviewView(MultipeerHandler()) { multipeer in
                UserSetupScreen(userVM: userVM,multipeerHandler: multipeer)
            }
        }
    }
}
