//
//  WarmUpCorrectScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct WarmUpCorrectScreen: View {
    var body: some View {
        LayoutView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Harap menunggu")
                    .font(.headingBig)
                Text("Sedang menunggu jawaban dari pasanganmu. setelah itu akan kami proses.")
                    .font(.paragraph)
            }
            WarmUpUserAnswerView(username: "Ricky", answer: "Ricky")
            WarmUpCardView {
                Text("Langkah awal yang baik!")
                    .font(.heading)
                    .foregroundColor(Color.avatarBackgroundTosca)
                    .padding(.bottom, 10)
                Text("Jawaban kalian sudah sesuai selamat. Selanjutnya akan lebih mudah untuk kalian.")
                    .font(.paragraph)
            }
            Spacer()
            ButtonView {
                //
            } label: {
                Text("Mulai")
            }
            .buttonStyle(.fill(.primary))

        }
    }
}

struct WarmUpCorrectScreen_Previews: PreviewProvider {
    static var previews: some View {
        WarmUpCorrectScreen()
    }
}
