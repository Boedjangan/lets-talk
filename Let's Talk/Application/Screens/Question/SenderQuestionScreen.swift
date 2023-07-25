//
//  SenderQuestionScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 25/07/23.
//

import SwiftUI

struct SenderQuestionScreen: View {
    @State private var timer: Int = 0
    @State var isRecording: Bool = false
    var question: String = "Test Dong"
    var body: some View {
        LayoutView(spacing:Spacing.title) {
            Spacer()
            Text("Ayo mulai obrolan kalian ❤️")
                .font(.heading)
            Spacer()
            VStack(spacing: Spacing.card){
                QuestionCardView(timer: $timer,isRecording: isRecording, question: question)
                    .onChange(of: isRecording) { value in
                        if value{
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                                    timer += 1
                                }
                        }
                    }
                ButtonView {
                    isRecording = true
                } label: {
                    Text("Mulai")
                }
                .buttonStyle(.fill(.primary))
            }
           
        }
    }
}

struct SenderQuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SenderQuestionScreen()
    }
}
