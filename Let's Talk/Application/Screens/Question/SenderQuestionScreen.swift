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
    @State var scheduler: Timer? = nil
    var question: String = "Test Dong"
    
    var body: some View {
        LayoutView(spacing:Spacing.title) {
            Spacer()
            
            Text("Ayo mulai obrolan kalian ❤️")
                .font(.heading)
            
            Spacer()
            
            VStack(spacing: Spacing.card) {
                QuestionCardView(timer: $timer,isRecording: isRecording, question: question)
                    .onChange(of: isRecording) { value in
                        if value{
                            startTimer()
                        }else{
                            stopTimer()
                        }
                    }
                
                ButtonView {
                    isRecording = !isRecording
                } label: {
                    Text("Mulai")
                }
                .buttonStyle(.fill(.primary))
            }
        }
    }
    
    func startTimer(){
        self.scheduler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            timer += 1
        }
    }
    
    func stopTimer(){
        self.scheduler?.invalidate()
        self.scheduler = nil
    }
}

struct SenderQuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SenderQuestionScreen()
    }
}
