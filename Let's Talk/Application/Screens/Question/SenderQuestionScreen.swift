//
//  SenderQuestionScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 25/07/23.
//

import SwiftUI

struct SenderQuestionScreen: View {
    @ObservedObject var questionVM: QuestionViewModel
    
    var question: String = "Test Dong"
    
    var body: some View {
        LayoutView(spacing:Spacing.title) {
            Spacer()

            Text("Ayo mulai obrolan kalian ❤️")
                .font(.heading)

            Spacer()

            VStack(spacing: Spacing.card) {
                QuestionCardView(timer: $questionVM.talkDuration, isRecording: questionVM.isRecordingAudio, question: question)

                // TODO: change to actual implementation still mocking
                ButtonView {
                    if questionVM.isRecordingAudio {
                        questionVM.stopRecording()
                    } else {
                        // TODO: change key to variable that named to question or question id so can be called later to playback
                        questionVM.startRecording(key: "test")
                    }
                    
//                    if questionVM.isPlayingAudio {
//                        questionVM.stopPlayback()
//                    } else {
//                        questionVM.startPlayback(key: "test")
//                    }
                } label: {
                    Text(questionVM.isRecordingAudio || questionVM.isPlayingAudio ? "Berhenti" : "Mulai")
                }
                .buttonStyle(.fill(.primary))
            }
        }
    }
}

//struct SenderQuestionScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SenderQuestionScreen()
//    }
//}
