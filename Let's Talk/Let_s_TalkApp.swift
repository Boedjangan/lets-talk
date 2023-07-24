//
//  Let_s_TalkApp.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 11/07/23.
//

import SwiftUI

enum OnboardingRoutes: String {
    case welcome
    case setup
    case pairing
    case congrats
    case done
}

@main
struct Let_s_TalkApp: App {
    @AppStorage("onboarding") var onboarding: String = OnboardingRoutes.welcome.rawValue
    
    @StateObject var userVM: UserViewModel = UserViewModel()
    @StateObject var dashboardNavigation = DashboardNavigationManager()
    @StateObject var loveLogNavigation = LoveLogNavigationManager()
    
    var body: some Scene {
        WindowGroup {
            switch(onboarding) {
            case "welcome":
                UserOnboardingScreen()
            case "setup":
                UserSetupScreen(userVM: userVM)
            case "pairing":
                UserPairingScreen(userVM: userVM)
            case "congrats":
                UserPairingSuccessScreen()
            case "done":
                TabBarView(dashboardNavigation: dashboardNavigation, loveLogNavigation: loveLogNavigation)
            default:
                UserOnboardingScreen()
            }
        }
    }
}
