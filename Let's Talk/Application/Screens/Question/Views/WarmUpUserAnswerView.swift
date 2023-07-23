//
//  WarmUpUserAnswerView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 22/07/23.
//

import SwiftUI

enum AnswerState {
    case isWaiting
    case isAnswered
    case isCorrect
    case isWrong
}

struct AnswerText: View {
    let username: String
    let answer: String
    let state: AnswerState
    let alignment: HorizontalAlignment
    
    var body: some View {
        VStack(alignment: alignment) {
            Text("Jawaban \(username)")
                .font(.warmUpAnswerHeading)
            
            switch(state) {
            case .isWaiting:
                Text("Menunggu jawaban...")
                    .font(.warmUpAnswer)
                    .foregroundColor(Color.warmUpAnswerWaiting)
            case .isAnswered:
                Text("\(answer)")
                    .font(.warmUpAnswer)
            case .isCorrect:
                HStack {
                    Text("\(answer)")
                        .font(.warmUpAnswer)
                    Image(systemName: "checkmark.circle.fill")
                }
                .foregroundColor(Color.warmUpAnswerCorrect)
            case .isWrong:
                HStack {
                    Text("\(answer)")
                        .font(.warmUpAnswer)
                    Image(systemName: "multiply.circle.fill")
                }
                .foregroundColor(Color.warmUpAnswerWrong)
            }
        }
    }
}

struct WarmUpAvatar: View {
    let image: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.avatarPlaceHolder)
                .frame(width: 84, height: 84)
            
            Image(systemName: image)
                .foregroundColor(Color.black)
                .font(.system(size: 60))
        }
    }
}

struct WarmUpUserAnswerView: View {
    let username: String
    let answer: String
    let state: AnswerState
    let image: String
    let inverted: Bool
    
    init(username: String, answer: String, answerState: AnswerState = .isWaiting, image: String = "person.fill", inverted: Bool = false) {
        self.username = username
        self.answer = answer
        self.state = answerState
        self.image = image
        self.inverted = inverted
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            if !inverted {
                WarmUpAvatar(image: image)
                AnswerText(username: username, answer: answer, state: state, alignment: .leading)
            }
            
            if inverted {
                AnswerText(username: username, answer: answer, state: state, alignment: .trailing)
                WarmUpAvatar(image: image)
            }
        }
    }
}

struct WarmUpUserAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView {
            WarmUpUserAnswerView(username: "Ethan", answer: "Rizky", answerState: .isCorrect, inverted: false)
            
            WarmUpUserAnswerView(username: "Anne", answer: "Rizky", answerState: .isCorrect, inverted: true)
        }
    }
}
