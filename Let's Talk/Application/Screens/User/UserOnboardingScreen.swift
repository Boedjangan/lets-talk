//
//  UserOnboardingScreen.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

struct UserOnboardingScreen: View {
    var body: some View {
        LayoutView {
            Spacer()
            HeroView(maleHero: "person.fill", femaleHero: "person")
            Spacer()
            Text("Welcome and Let’s Talk")
                .font(Font.system(size: 16, weight: .bold, design: .rounded))
                .padding(.vertical, 20)
            Text("Where love and communication come together to create stronger and more meaningful relationships")
                .font(Font.system(size: 16, weight: .regular, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 100)
            ButtonView {
                //
            } label: {
                Text("Next")
            }
            .buttonStyle(.primary)
        }
    }
}

struct UserOnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserOnboardingScreen()
    }
}
