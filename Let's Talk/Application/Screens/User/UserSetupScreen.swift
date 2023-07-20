//
//  UserSetupScreen.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

struct UserSetupScreen: View {
    @State private var userName: String = ""
    @State private var gender: Gender = .male
    var body: some View {
        LayoutView {
            Spacer()
            Image(systemName: "apple.logo")
                .font(.system(size: 100))
                .frame(maxHeight: 300)
            Spacer()
            Text("Bantu kami lebih mengenal kamu")
            Text("Siapa nama panggilan kamu?")
                .font(.heading)
                .padding(.bottom, 50)
            TextField("Username", text: $userName, prompt: Text("Sebutkan namamu").foregroundColor(.white))
                .multilineTextAlignment(.center)
                .overlay(Divider().background().offset(y: 5), alignment: .bottom)
                .padding(.bottom, 50)
            GenderSelectorView(gender: $gender)
                .padding(.bottom, 50)
            Spacer()
            ButtonView {
                //
            } label: {
                Text("Selanjutnya")
            }
            .buttonStyle(.primary)
        }
    }
}

struct UserSetupScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserSetupScreen()
    }
}
