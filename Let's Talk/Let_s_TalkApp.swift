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
    
    // MARK - View Model Initialization
    @StateObject var userVM: UserViewModel = UserViewModel()
    @StateObject var questionVM: QuestionViewModel = QuestionViewModel()
    
    // MARK - APP Routes
    @StateObject var dashboardNavigation = DashboardNavigationManager()
    @StateObject var loveLogNavigation = LoveLogNavigationManager()
    @StateObject var multipeerHandler : MultipeerHandler = MultipeerHandler()
    
    var body: some Scene {
        WindowGroup {
            switch(onboarding) {
            case "welcome":
                UserOnboardingScreen()
            case "setup":
                UserSetupScreen(userVM: userVM, multipeerHandler: multipeerHandler)
            case "pairing":
                UserPairingScreen(multipeerHandler: multipeerHandler, userVM: userVM)
            case "congrats":
                UserPairingSuccessScreen(userVM: userVM)
            case "done":
                TabBarView(dashboardNavigation: dashboardNavigation, loveLogNavigation: loveLogNavigation)
            default:
                UserOnboardingScreen()
            }
        }
    }
}
