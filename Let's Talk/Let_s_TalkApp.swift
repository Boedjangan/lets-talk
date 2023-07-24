//
//  Let_s_TalkApp.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 11/07/23.
//

import SwiftUI

@main
struct Let_s_TalkApp: App {
    @StateObject var userVM: UserViewModel = UserViewModel()

    var body: some Scene {
        WindowGroup {
//            VStack {
//                Text("HEHE")
//            }
            LayoutView{
                UserPairingScreen(userVM: userVM)
            }
        }
    }
}
