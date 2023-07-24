//
//  WarmUpScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 20/07/23.
//

import SwiftUI

struct WarmUpScreen: View {
    @State private var answer: String = ""
    let warmUpQuestion: String = "Siapa teman terbaik kamu?"
    var body: some View {
        LayoutView {
            Text("Warming Up!")
                .font(.headingBig)
                .padding(.vertical)
            WarmUpTimerView()
            Text("Jawab pertanyaan ini dengan pasanganmu")
                .font(.paragraph)
                .padding(.vertical, 20)
            WarmUpCardView {
                Text(warmUpQuestion)
                    .font(.paragraph)
            }
            TextFieldView(text: $answer, placeholder: "Tulis jawabanmu disini")
                .padding(.vertical, 20)
            Spacer()
            ButtonView {
                //
            } label: {
                Text("Jawab")
            }
            .buttonStyle(.fill(.primary))
        }
    }
}

struct WarmUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        WarmUpScreen()
    }
}
