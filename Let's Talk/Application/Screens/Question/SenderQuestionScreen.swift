//
//  SenderQuestionScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 25/07/23.
//

import SwiftUI

struct SenderQuestionScreen: View {
    @EnvironmentObject var navigation: DashboardNavigationManager
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    @EnvironmentObject var questionVM: QuestionViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    @State var timeRemaining: Double = 10
    @State var showChangeAlert: Bool = false
    
    @State var isReady = false
    
    var body: some View {
        LayoutView(spacing:Spacing.title) {
            if !isReady {
                LoadingView()
            }
            
            if isReady {
                Spacer()

                Text("Ayo mulai obrolan kalian ❤️")
                    .font(.heading)

                Spacer()

                VStack(spacing: Spacing.card) {
                    QuestionCardView(timer: $questionVM.talkDuration, isRecording: questionVM.isRecordingAudio, question: questionVM.currentQuestion?.question ?? "kosong")

                    ButtonView {
                        if questionVM.isRecordingAudio {
                            // MARK - Send that you are stopping recording
                            let customData = MultipeerData(dataType: .stopRecording)
                            
                            do {
                                let encodedData = try JSONEncoder().encode(customData)
                                
                                multipeerHandler.sendData(encodedData)
                            } catch {
                                print("ERROR: \(error.localizedDescription)")
                            }
                            
                            questionVM.stopRecording()
                            showChangeAlert = true
                        } else {
                            guard let key = getKeyString() else { return }
                            
                            // MARK - Send that you are starting recording
                            let customData = MultipeerData(dataType: .startRecording)
                            
                            do {
                                let encodedData = try JSONEncoder().encode(customData)
                                
                                multipeerHandler.sendData(encodedData)
                            } catch {
                                print("ERROR: \(error.localizedDescription)")
                            }
                            
                            questionVM.startRecording(key: key)
                        }
                    } label: {
                        Text(questionVM.isRecordingAudio ? "Selesai" : "Mulai")
                    }
                    .buttonStyle(.fill(.primary))
                    .alert(isPresented: $showChangeAlert) {
                        if questionVM.hasSwitchedRole {
                           return Alert(
                                title: Text("Selamat!"),
                                message: Text("Silahkan abadikan momen ini bersama pasanganmu."),
                                dismissButton: .default(Text("Okay")) {
                                    // MARK - Navigate to Add Media
                                    navigation.push(to: .add_media)
                                }
                            )
                        } else {
                           return Alert(
                                title: Text("Tukar Giliran"),
                                message: Text("Sekarang giliran pasangan kamu untuk sharing denganmu."),
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
                                    navigation.push(to: .question_receiver)
                                }
                            )
                        }
                    }
                }
            }
        }
        .onChange(of: multipeerHandler.coupleReadyAt, perform: { newValue in
            // Mark - Check if your couple is ready in receiver screen
            if newValue == "question_receiver" {
                isReady = true
            }
        })
        .onAppear {
            // MARK - Check if couple at receiver yet
            if multipeerHandler.coupleReadyAt == "question_receiver" {
                isReady = true
            }
            
            // MARK - Send that you are ready in question sender screen
            let customData = MultipeerData(dataType: .isReadyAt, data: "question_sender".data(using: .utf8))
            
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
    
    func getKeyString() -> String? {
        guard let topicLevel =  questionVM.currentQuestion?.topicLevel else { return nil }
        guard let questionOrder = questionVM.currentQuestion?.order else { return nil }
        
        return "T\(topicLevel)-Q\(questionOrder)"
    }
}

struct SenderQuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(QuestionViewModel()) { question in
            StatefulObjectPreviewView(DashboardNavigationManager()) { nav in
                StatefulObjectPreviewView(MultipeerHandler()) { multi in
                    SenderQuestionScreen()
                        .environmentObject(question)
                        .environmentObject(nav)
                        .environmentObject(multi)
                }
            }
        }
    }
}
