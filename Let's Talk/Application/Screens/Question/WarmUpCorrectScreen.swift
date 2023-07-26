//
//  WarmUpCorrectScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct WarmUpCorrectScreen: View {
    
    @ObservedObject var userVM:UserViewModel
    @ObservedObject var multipeerHandler: MultipeerHandler
    @State var userState : AnswerState = .isCorrect
    @State var coupleState : AnswerState = .isCorrect
    @State var titleAnswer:String = " ini title"
    @State var resultAnswer:String = "ini answer"
    var userName: String
    var coupleName: String
    var gender:String
    var userAnswer: String = "test"
    var coupleAnswer: String = "test"
    
    
    init(userVM: UserViewModel,multipeerHandler:MultipeerHandler) {
        self.userVM = userVM
        self.multipeerHandler = multipeerHandler
        self.userName = userVM.user.username
        self.coupleName = userVM.user.coupleName ?? "couple"
        if userVM.user.gender == .male {
            self.gender = "Male"
        }else{
            self.gender = "Female"
        }
    }
    
    var body: some View {
        LayoutView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Harap menunggu")
                    .font(.headingBig)
                Text("Sedang menunggu jawaban dari pasanganmu. setelah itu akan kami proses.")
                    .font(.paragraph)
            }
            
            WarmUpUserAnswerView(username: userName, answer: userAnswer,answerState: userState ,gender: gender)
            WarmUpUserAnswerView(username: coupleName, answer: coupleAnswer,answerState:coupleState, inverted: true, gender: gender == "Male" ? "Female" : "Male")
            
            WarmUpCardView {
                Text(titleAnswer)
                    .font(.heading)
                    .foregroundColor(Color.subQuestionTextBackground)
                    .padding(.bottom, 10)
                Text(resultAnswer)
                    .font(.paragraph)
            }
            
            Spacer()
            
            ButtonView {
                //
            } label: {
                Text("Mulai")
            }
            .buttonStyle(.fill(.primary))

        }.onChange(of: userState, perform: { newValue in
            getAnswerTitle()
        })
        .onAppear(perform: {
            getAnswerTitle()
        })
    }
    
    func getAnswerTitle() {
        
        if userState == .isCorrect{
            titleAnswer = "Langkah awal yang baik"
            resultAnswer = "Jawaban kalian sudah sesuai selamat. Selanjutnya akan lebih mudah untuk kalian."
        }else if userState == .isWrong{
            titleAnswer = "Yah jawaban kalian tidak sama"
            resultAnswer = "Tapi tidak apa-apa, kalian akan lebih mengenal di topik ini dengan mengikuti aktivitas selanjutnya!"
        }else {
            titleAnswer =  ""
            resultAnswer = "Menganailisa jawaban kalian"
        }
    }
}

struct WarmUpCorrectScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(UserViewModel()) { userVM in
            StatefulObjectPreviewView(MultipeerHandler()) { multipeer in
                WarmUpCorrectScreen(userVM: userVM,multipeerHandler: multipeer)
            }
        }
      
    }
}
