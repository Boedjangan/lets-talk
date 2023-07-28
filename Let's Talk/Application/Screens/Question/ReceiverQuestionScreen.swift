//
//  ReceiverQuestionScreen.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 25/07/23.
//

import SwiftUI

struct ReceiverQuestionScreen: View {
    @EnvironmentObject var questionVM: QuestionViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var navigation: DashboardNavigationManager
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    
    @State var showChangeAlert: Bool = false
    
    @State var isReady = false
    
    var body: some View {
        LayoutView(spacing: Spacing.title) {
            if !isReady {
                LoadingView()
            }
            
            if isReady {
                Text("Ayo mulai obrolan kalian ❤️")
                    .font(.heading)
                
                Spacer()
                
                VStack(spacing: 40) {
                    QuestionCardView(timer: $questionVM.coupleTalkDuration, isRecording: questionVM.isCoupleRecordingAudio, question: questionVM.currentQuestion?.question ?? "kosong")
                    
                    ForEach(questionVM.currentQuestion?.subQuestions ?? []) { subQuestion in
                        SubQuestionTextView(text: subQuestion.subQuestion)
                    }
                }
            }
        }
        .alert(isPresented: $showChangeAlert) {
            if questionVM.hasSwitchedRole {
               return Alert(
                    title: Text("Tukar Giliran"),
                    message: Text("Sekarang giliran kamu untuk sharing dengan pasanganmu."),
                    dismissButton: .default(Text("Okay")) {
                        // MARK - Navigate to Add Media
                        navigation.push(to: .overview)
                    }
                )
            } else {
               return Alert(
                    title: Text("Tukar Giliran"),
                    message: Text("Sekarang giliran kamu untuk sharing dengan pasanganmu."),
                    dismissButton: .default(Text("Okay")) {
                        
                        // MARK - Switching Role
                        switch(userVM.myRole) {
                        case .receiver:
                            userVM.myRole = .sender
                        case .sender:
                            userVM.myRole = .receiver
                        default:
                            print("Not found")
                        }
                        
                        questionVM.hasSwitchedRole = true
                        
                        // MARK - Send that you are switching role
                        let customData = MultipeerData(dataType: .switchRole)
                        
                        do {
                            let encodedData = try JSONEncoder().encode(customData)
                            
                            multipeerHandler.sendData(encodedData)
                        } catch {
                            print("ERROR: \(error.localizedDescription)")
                        }
                        
                        // MARK - Navigate to Receiver, switching role
                        showChangeAlert = false
                        navigation.push(to: .question_sender)
                    }
                )
            }
        }
        .onChange(of: multipeerHandler.coupleRecordStatus, perform: { recordStatus in
            switch(recordStatus) {
            case .start:
                questionVM.startTimerReceiver()
                questionVM.isCoupleRecordingAudio = true
            case .stop:
                questionVM.stopTimerReceiver()
                questionVM.isCoupleRecordingAudio = false
                showChangeAlert = true
            case .idle:
                questionVM.stopTimerReceiver()
                questionVM.isCoupleRecordingAudio = false
            }
        })
        .onChange(of: multipeerHandler.coupleReadyAt, perform: { newValue in
            // Mark - Check if your couple is ready in sender screen
            if newValue == "question_sender" {
                isReady = true
            }
        })
        .onAppear {
            // MARK - Check if couple at sender yet
            if multipeerHandler.coupleReadyAt == "question_sender" {
                isReady = true
            }
            
            // MARK - Send that you are ready in question receiver screen
            let customData = MultipeerData(dataType: .isReadyAt, data: "question_receiver".data(using: .utf8))
            
            do {
                let encodedData = try JSONEncoder().encode(customData)
                
                multipeerHandler.sendData(encodedData)
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
        .onDisappear {
            isReady = false
        }
    }
}

struct ReceiverQuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(QuestionViewModel()) { question in
            ReceiverQuestionScreen()
                .environmentObject(question)
        }
    }
}
