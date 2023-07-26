//
//  WarmUpScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 20/07/23.
//

import SwiftUI

struct WarmUpScreen: View {
    @EnvironmentObject var navigation: DashboardNavigationManager
    @ObservedObject var questionVM: QuestionViewModel
    
    let question: QuestionEntity?
    
    init(topicId: UUID, questionVM: QuestionViewModel) {
        self.questionVM = questionVM
        
        if let incompleteQuestion = questionVM.getQuestionByTopicId(topicId: topicId) {
            self.question = incompleteQuestion
        } else {
            self.question = nil
        }
    }
    
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
                Text(question?.warmUp ?? "")
                    .font(.paragraph)
            }
            
            TextFieldView(text: $questionVM.myWarmUpAnswer, placeholder: "Tulis jawabanmu disini")
                .padding(.vertical, 20)
            
            Spacer()
            
            ButtonView {
                if questionVM.myWarmUpAnswer.isNotEmpty {
                    navigation.push(to: .warmup_result)
                }
            } label: {
                Text("Jawab")
            }
            .buttonStyle(.fill(.primary))
        }
    }
}

struct WarmUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(QuestionViewModel()) { question in
            StatefulObjectPreviewView(DashboardNavigationManager()) { nav in
                WarmUpScreen(topicId: UUID(), questionVM: question)
                    .environmentObject(nav)
            }
        }
    }
}
