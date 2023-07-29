//
//  WarmUpCorrectScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct WarmUpCorrectScreen: View {
    @EnvironmentObject var navigation: DashboardNavigationManager
    @EnvironmentObject var questionVM: QuestionViewModel
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    
    @ObservedObject var userVM: UserViewModel
    
    @State var userState: AnswerState = .isAnswered
    @State var coupleState: AnswerState = .isWaiting
    @State var titleAnswer: String = "ini title"
    @State var resultAnswer: String = "ini answer"
    
    @State var isReady = false
    @State var isChecked = false
    
    var gender: String
    
    init(userVM: UserViewModel) {
        self.userVM = userVM
        
        if userVM.user.gender == .male {
            self.gender = "Male"
        } else {
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
            
            WarmUpUserAnswerView(username: userVM.user.username, answer: questionVM.myWarmUpAnswer, answerState: userState, gender: gender)
            
            WarmUpUserAnswerView(username: userVM.user.coupleName ?? "", answer: multipeerHandler.coupleWarmUpAnswer, answerState: coupleState, inverted: true, gender: gender == "Male" ? "Female" : "Male")
            
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
                if isChecked {
                    navigation.push(to: userVM.myRole == .sender ? .question_sender : .question_receiver)
                }
            } label: {
                Text("Mulai")
            }
            .buttonStyle(.fill(.primary))
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .onChange(of: multipeerHandler.coupleReadyAt, perform: { newValue in
            if newValue == "warmup_result" {
                isReady = true
                
                let isCorrect = checkWarmupAnswer(myAnswer: questionVM.myWarmUpAnswer, coupleAnswer: multipeerHandler.coupleWarmUpAnswer)
                
                if isCorrect {
                    userState = .isCorrect
                    coupleState = .isCorrect
                } else {
                    userState = .isWrong
                    coupleState = .isWrong
                }
                
                isChecked = true
            }
        })
        .onChange(of: multipeerHandler.coupleWarmUpAnswer, perform: { coupleAnswer in
            if coupleAnswer.isNotEmpty {
                coupleState = .isAnswered
                
                let isCorrect = checkWarmupAnswer(myAnswer: questionVM.myWarmUpAnswer, coupleAnswer: multipeerHandler.coupleWarmUpAnswer)
                
                if isCorrect {
                    userState = .isCorrect
                    coupleState = .isCorrect
                } else {
                    userState = .isWrong
                    coupleState = .isWrong
                }
                
                isChecked = true
            }
        })
        .onChange(of: userState, perform: { newValue in
            getAnswerTitle()
        })
        .onAppear(perform: {
            // Disable the idle timer again when the view disappears
            UIApplication.shared.isIdleTimerDisabled = true
            
            // Update status if both are in this page
            if multipeerHandler.coupleReadyAt == "warmup_result" {
                isReady = true
                
                coupleState = .isAnswered
                
                let isCorrect = checkWarmupAnswer(myAnswer: questionVM.myWarmUpAnswer, coupleAnswer: multipeerHandler.coupleWarmUpAnswer)
                
                if isCorrect {
                    userState = .isCorrect
                    coupleState = .isCorrect
                } else {
                    userState = .isWrong
                    coupleState = .isWrong
                }
                
                isChecked = true
            }
            
            // Update Title
            getAnswerTitle()
            
            
            // MARK - Send location
            let customData = MultipeerData(dataType: .isReadyAt, data: "warmup_result".data(using: .utf8))
            
            do {
                let encodedData = try JSONEncoder().encode(customData)
                
                multipeerHandler.sendData(encodedData)
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        })
        .onDisappear {
            // Enable the idle timer again when the view disappears
            UIApplication.shared.isIdleTimerDisabled = false
            
            isReady = false
            isChecked = false
        }
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
    
    func checkWarmupAnswer(myAnswer: String, coupleAnswer: String) -> Bool {
        if myAnswer.isEmpty && coupleAnswer.isEmpty {
            return false
        }
        
        let A = myAnswer.lowercased()
        let B = coupleAnswer.lowercased()
        
        return  A == B
    }
}

struct WarmUpCorrectScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(UserViewModel()) { userVM in
            WarmUpCorrectScreen(userVM: userVM)
        }
    }
}
