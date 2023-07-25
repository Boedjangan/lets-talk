//
//  QuestionSessionOverviewScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct QuestionSessionOverviewScreen: View {
    let image: String = "sample"
    let maleTalkTime: Int = 15
    let femaleTalkTime: Int = 29
    var body: some View {
        LayoutView {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Hore. Obrolan kalian sudah selesai 🎉")
                        .font(.warmUpAnswerHeading)
                    Text("Berikut pencapaian obrolan kalian :")
                        .font(.paragraph)
                }
                Spacer()
            }
            TalkTimeDetailCardView(maleTalkTime: maleTalkTime, femaleTalkTime: femaleTalkTime)
            ImagePreview(image: image)
            Spacer()
            ButtonView {
                //
            } label: {
                Text("Kembali ke Dashboard")
            }
            .buttonStyle(.fill(.primary))
        }
    }
}

struct ImagePreview: View {
    var image: String = "sample"
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(width: 350, height: 350)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.6), radius: 10)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .clipped()
    }
}

struct TalkTimeDetailCardView: View {
    var maleTalkTime: Int = 0
    var femaleTalkTime: Int = 0
    var coupleTalkTime: Int {maleTalkTime + femaleTalkTime}
    var body: some View {
        HStack {
            VStack {
                Text("+\(maleTalkTime) Menit")
                    .font(.paragraph)
                AvatarView()
                    .scaleEffect(0.5)
                    .padding(.horizontal, -60)
                    .padding(.vertical, -40)
            }
            VStack {
                Text("\(coupleTalkTime) Menit")
                    .font(.headingBig)
                Text("Waktu kebersamaan kalian ketika mengobrol.")
                    .font(.genderPickerLabel)
                    .multilineTextAlignment(.center)
            }
            .multilineTextAlignment(.center)
            VStack {
                Text("+\(femaleTalkTime) Menit")
                    .font(.paragraph)
                AvatarView()
                    .scaleEffect(0.5)
                    .padding(.horizontal, -60)
                    .padding(.vertical, -40)
            }
        }
        .padding()
        .padding(.bottom, 10)
        .background(Color("Ash"))
        .cornerRadius(10)
        .padding(.vertical, 20)
    }
}

struct QuestionSessionOverviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuestionSessionOverviewScreen()
    }
}
