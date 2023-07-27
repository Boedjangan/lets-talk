//
//  WarmUpScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 20/07/23.
//

import SwiftUI

struct WarmUpScreen: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var questionVM: QuestionViewModel
    @EnvironmentObject var navigation: DashboardNavigationManager
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    
    @State var timeRemaining: Double = 10
    @State var timer: Timer?
    
    @State var isReady = false
    
    var body: some View {
        LayoutView {
            if !isReady {
                LoadingView()
            }
            
            if isReady {
                Text("Warming Up!")
                    .font(.headingBig)
                    .padding(.vertical)
                
                WarmUpTimerView(timeRemaining: timeRemaining, timer: timer)
                    .onAppear {
                        startTimer()
                    }
                    .onChange(of: timeRemaining) { val in
                        if val <= 0 {
                            stopTimer()
                        }
                        
                        if val == 0 {
                            let customData = MultipeerData(dataType: .warmUpAnswer, data: questionVM.myWarmUpAnswer.data(using: .utf8))
                            
                            do {
                                let encodedData = try JSONEncoder().encode(customData)
                                
                                multipeerHandler.sendData(encodedData)
                            } catch {
                                print("ERROR: \(error.localizedDescription)")
                            }

                                navigation.push(to: .warmup_result)
                        }
                    }
                
                Text("Jawab pertanyaan ini dengan pasanganmu")
                    .font(.paragraph)
                    .padding(.vertical, 20)
                
                WarmUpCardView {
                    Text(questionVM.currentQuestion?.warmUp.replacingOccurrences(of: "user", with: getName()) ?? "")
                        .font(.paragraph)
                }
                
                TextFieldView(text: $questionVM.myWarmUpAnswer, placeholder: "Tulis jawabanmu disini")
                    .padding(.vertical, 20)
                
                Spacer()
                
                ButtonView {
                    if questionVM.myWarmUpAnswer.isNotEmpty {
                        let customData = MultipeerData(dataType: .warmUpAnswer, data: questionVM.myWarmUpAnswer.data(using: .utf8))
                        
                        do {
                            let encodedData = try JSONEncoder().encode(customData)
                            
                            multipeerHandler.sendData(encodedData)
                        } catch {
                            print("ERROR: \(error.localizedDescription)")
                        }
                        
                            navigation.push(to: .warmup_result)
                    }
                } label: {
                    Text("Jawab")
                }
                .buttonStyle(.fill(.primary))
            }
        }
        .onChange(of: multipeerHandler.coupleReadyAt, perform: { newValue in
            if newValue == "warmup" {
                isReady = true
            }
        })
        .onAppear {
            if multipeerHandler.coupleReadyAt == "warmup" {
                isReady = true
            }
            
            let customData = MultipeerData(dataType: .isReadyAt, data: "warmup".data(using: .utf8))
            
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
        .toolbar(.hidden, for: .tabBar)
    }
    
    // MARK - Timer Logic
    func startTimer() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { _ in
            self.timeRemaining -= 0.001
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timeRemaining = 0
    }
    
    func getName() -> String {
        guard let myRole = userVM.myRole else { return "Error" }
        
        switch(myRole) {
        case .receiver:
            return userVM.user.coupleName ?? "Error"
        case .sender:
            return userVM.user.username
        }
    }
}

struct WarmUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(QuestionViewModel()) { question in
            StatefulObjectPreviewView(DashboardNavigationManager()) { nav in
                StatefulObjectPreviewView(MultipeerHandler()) { multi in
                    WarmUpScreen()
                        .environmentObject(question)
                        .environmentObject(nav)
                        .environmentObject(multi)
                }
            }
        }
    }
}
