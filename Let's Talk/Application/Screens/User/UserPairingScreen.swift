//
//  UserPairingScreen.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

// TODO: multipeer dipindahin ke root
// TODO: pindah screen pairing success 
struct UserPairingScreen: View {
    @AppStorage("onboarding") var onboarding: String = OnboardingRoutes.welcome.rawValue
    
    @ObservedObject var multipeerHandler : MultipeerHandler
    @ObservedObject var userVM: UserViewModel
    @State var isPresent : Bool = false
    
    init(multipeerHandler: MultipeerHandler, userVM: UserViewModel) {
        self.multipeerHandler = multipeerHandler
        self.userVM = userVM
        
        // Mulai jalanin advertising biar kelihatan di pasangan
        multipeerHandler.advertiser.startAdvertisingPeer()
    }

    var body: some View {
        LayoutView{
            Group{
                Text("Sambungkan dengan pasanganmu")
                    .padding(.bottom,24)
                    .font(Font.subHeading)
                Text("Dekatkan iphone dan cari perangkat pasanganmu")
            }
           
            Spacer()
            
            PairListView(multipeerHandler: multipeerHandler, userVM: userVM)
                
            Spacer()
        }.onAppear {
            // Aktifin nyari pasangan yg nampak
            multipeerHandler.startBrowsing()
        }.onDisappear{
            // Berhenti nyari pasangan yg nampak
            multipeerHandler.stopBrowsing()
        }
        .onChange(of: multipeerHandler.isReady) { newState in
            if newState {
                // Save couple name
                userVM.updateCouple(coupleID: multipeerHandler.coupleID!, coupleName: multipeerHandler.coupleName!)
                
                onboarding = OnboardingRoutes.congrats.rawValue
            }
        }
    }
}

struct UserPairingScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(UserViewModel()) { userVM in
            StatefulObjectPreviewView(MultipeerHandler()) { multipeer in
                UserPairingScreen(multipeerHandler: multipeer, userVM: userVM)
            }
        }
    }
}
