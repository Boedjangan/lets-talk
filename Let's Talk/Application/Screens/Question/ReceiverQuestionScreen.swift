//
//  ReceiverQuestionScreen.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 25/07/23.
//

import SwiftUI

struct ReceiverQuestionScreen: View {
    @State private var timer: Int = 0
    @State var isRecording: Bool = false
    
    var question: String = "Test Dong 2"
    
    var body: some View {
        LayoutView(spacing: Spacing.title){
            Text("Ayo mulai obrolan kalian ❤️")
                .font(.heading)
            Spacer()
            VStack(spacing: 40){
                QuestionCardView(timer: $timer,isRecording: isRecording, question: question,typeQuestion: .receiver)
                    .onChange(of: isRecording) { value in
                        if value{
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                                    timer += 1
                                }
                        }
                    }
                SubQuestionTextView(text: "Test1")
                SubQuestionTextView(text: "test2")
                SubQuestionTextView(text: "test2")
                
            }
        }
    }
}

struct ReceiverQuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReceiverQuestionScreen()
    }
}
