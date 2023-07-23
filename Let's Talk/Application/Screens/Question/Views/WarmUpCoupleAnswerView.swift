//
//  WarmUpCoupleAnswerView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct WarmUpCoupleAnswerView: View {
    var body: some View {
        VStack {
            HStack {
                AvatarView()
                    .scaleEffect(0.5)
                VStack(alignment: .leading) {
                    Text("Jawaban Ethan")
                        .font(.heading)
                    HStack {
                        Text("Jawaban")
                        Image(systemName: "checkmark.circle.fill")
                    }
                    .font(.paragraph)
                    .foregroundColor(Color.avatarBackgroundTosca)
                }
                Spacer()
            }
            Divider().background()
            HStack {
                
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Jawaban Ethan")
                        .font(.heading)
                    HStack {
                        Text("Jawaban")
                        Image(systemName: "checkmark.circle.fill")
                    }
                    .font(.paragraph)
                    .foregroundColor(Color.avatarBackgroundTosca)
                }
                AvatarView()
                    .scaleEffect(0.5)
            }
        }
    }
}

struct WarmUpCoupleAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        WarmUpCoupleAnswerView()
    }
}
