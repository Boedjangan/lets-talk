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
    let gender: String
    let radius:CGFloat = 84
    var body: some View {
//        ZStack {
            //            Circle()
            //                .foregroundColor(Color.avatarPlaceHolder)
            //                .frame(width: 84, height: 84)
            //
            //            Image(systemName: image)
            //                .foregroundColor(Color.black)
            //                .font(.system(size: 60))
            //        }
            ZStack{
                Circle()
                    .fill(gender == "Male" ? Color.avatarBackgroundTosca : Color.avatarBackgroundPurple)
                    .frame(width:radius,height: radius)
                Image(gender)
                    .resizable()
                    .scaledToFit().frame(width: radius,height: radius)
                    .foregroundColor(Color.black)
                    .padding(.top, 10)
            }
            .frame(width: radius, height: radius)
            .clipShape(Circle())
            .padding(.bottom,18)
        }
    }
    
    struct WarmUpUserAnswerView: View {
        let username: String
        let answer: String
        let state: AnswerState
        let image: String
        let inverted: Bool
        var gender = "Male"
        
        init(username: String, answer: String, answerState: AnswerState = .isWaiting, image: String = "person.fill", inverted: Bool = false,gender: String) {
            self.username = username
            self.answer = answer
            self.state = answerState
            self.image = image
            self.inverted = inverted
            self.gender = gender
        }
        
        var body: some View {
            HStack(alignment: .center, spacing: 12) {
                if !inverted {
                    WarmUpAvatar(gender: gender)
                    AnswerText(username: username, answer: answer, state: state, alignment: .leading)
                    Spacer()
                }
                
                if inverted {
                    Spacer()
                    AnswerText(username: username, answer: answer, state: state, alignment: .trailing)
                    WarmUpAvatar(gender: gender)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    struct WarmUpUserAnswerView_Previews: PreviewProvider {
        static var previews: some View {
            LayoutView {
                WarmUpUserAnswerView(username: "Ethan", answer: "panjang kali", answerState: .isAnswered, inverted: false,gender:"Male")
                
                WarmUpUserAnswerView(username: "Anne", answer: "panjang kali", answerState: .isAnswered, inverted: true,gender: "Female")
            }
        }
    }
