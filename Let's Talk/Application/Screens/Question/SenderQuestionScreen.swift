//
//  SenderQuestionScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 25/07/23.
//

import SwiftUI

struct SenderQuestionScreen: View {
    @State private var timer: Int = 0
    var question: String = "Test Dong"
    var body: some View {
        LayoutView {
            Spacer()
            Text("Ayo mulai obrolan kalian ❤️")
                .font(.heading)
            Spacer()
            QuestionCardView(timer: $timer, question: question)
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

struct SenderQuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SenderQuestionScreen()
    }
}
