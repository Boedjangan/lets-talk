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
            VStack {
                
                Spacer()
                HStack {
                    Image(systemName: "person")
                        .offset(y: -40)
                    Image(systemName: "person")
                        .offset(y: 40)
                }
                .font(Font.system(size: 150, weight: .regular, design: .rounded))
                .frame(maxHeight: 300)
                Spacer()
                Text("Welcome and Let’s Talk")
                    .font(Font.system(size: 16, weight: .bold, design: .rounded))
                    .padding(.vertical, 20)
                Text("Where love and communication come together to create stronger and more meaningful relationships")
                    .font(Font.system(size: 16, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                Button("Next", action: {
                    // Add action here
                })
                .buttonStyle(PrimaryButtonStyle())
            }
        }
    }
}

struct UserOnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserOnboardingScreen()
    }
}
