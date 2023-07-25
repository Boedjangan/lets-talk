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
    @ObservedObject var userVM:UserViewModel
    
    init(multipeerHandler:MultipeerHandler, userVM:UserViewModel){
        self.multipeerHandler = multipeerHandler
        self.userVM = userVM
        multipeerHandler.advertiser.startAdvertisingPeer()
//        multipeerHandler.userName = userVM.user.username
    }
    
//    @ObservedObject var dashboardRoutes: DashboardNavigationManager
    
    @State var isPresent : Bool = false
    
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
            multipeerHandler.startBrowsing()
        }.onDisappear{
            multipeerHandler.stopBrowsing()
        }
        .onChange(of: multipeerHandler.state) { newState in
            if newState == .connected {
                print(multipeerHandler.coupleID as Any , "<<<ini")
                print(multipeerHandler.coupleName as Any , "<<<ini bana")
                userVM.updateCouple(coupleID: multipeerHandler.coupleID!, coupleName: multipeerHandler.coupleName!)
                onboarding = OnboardingRoutes.congrats.rawValue
                print("ganti screeen")
            }
            
        }
    }
}

//struct UserPairingScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulObjectPreviewView(UserViewModel()) { userVM in
//            UserPairingScreen(userVM:userVM)
//                    }
//        
//    }
//}
