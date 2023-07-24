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
    @StateObject var multipeerHandler : MultipeerHandler = MultipeerHandler()
    @ObservedObject var userVM:UserViewModel
    
//    @ObservedObject var dashboardRoutes: DashboardNavigationManager
    
    @State var isPresent : Bool = false
    
    var body: some View {
        VStack(){
            Group{
                Text("Sambungkan dengan pasanganmu")
                    .padding(.bottom,24)
                    .font(Font.subHeading)
                Text("Dekatkan iphone dan cari perangkat pasanganmu")
            }
           
            Spacer()
            PairListView()
                .environmentObject(multipeerHandler)
            Spacer()
        }.onAppear {
            multipeerHandler.startBrowsing()
        }.onDisappear{
            multipeerHandler.stopBrowsing()
        }
        .onChange(of: multipeerHandler.state) { newState in
            if newState == .connected {
                print(multipeerHandler.coupleID as Any , "<<<ini")
                userVM.updateCoupleID(coupleID: multipeerHandler.coupleID!)
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
