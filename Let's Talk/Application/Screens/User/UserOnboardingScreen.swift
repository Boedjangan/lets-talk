//
//  UserOnboardingScreen.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

struct UserOnboardingScreen: View {
    @AppStorage("onboarding") var onboarding: String = OnboardingRoutes.welcome.rawValue
    
    var body: some View {
        LayoutView {
            Spacer()
            HeroView()
            Spacer()
            Text("Welcome and Let’s Talk")
                .font(.heading)
                .padding(.vertical, 20)
            Text("Where love and communication come together to create stronger and more meaningful relationships")
                .font(.paragraph)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 100)
            ButtonView {
                onboarding = OnboardingRoutes.setup.rawValue
            } label: {
                Text("Next")
            }
            .buttonStyle(.fill())
        }
    }
}

struct UserOnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserOnboardingScreen()
    }
}
