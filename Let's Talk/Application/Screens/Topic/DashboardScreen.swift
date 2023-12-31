//
//  DashboardScreen.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import SwiftUI
import Combine

struct DashboardScreen: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var topicVM: TopicViewModel
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    
    @State var isReady = false
    @State var observedCouleReadyAt: AnyCancellable?
    
    var body: some View {
        LayoutView(spacing: 40) {
            if !isReady {
                UserDisconectedScreen()
            }
           
            if isReady {
                TalkTimeView(talkTime: userVM.user.talkDuration ?? 0)
                
                GreetingView(userName: userVM.user.username)
                
                TopicListView(topics: topicVM.topics)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onChange(of: multipeerHandler.coupleReadyAt, perform: { newValue in
            if newValue == "dashboard" {
                isReady = true
            }
        })
        .onChange(of: multipeerHandler.state) { newState in
            if newState == .connected {
                multipeerHandler.coupleReadyAt = "dashboard"
                
                let customData = MultipeerData(dataType: .isReadyAt, data: "dashboard".data(using: .utf8))
                
                do {
                    let encodedData = try JSONEncoder().encode(customData)
                    
                    multipeerHandler.sendData(encodedData)
                } catch {
                    print("ERROR: \(error.localizedDescription)")
                }
            }
        }
        .onAppear {
            if multipeerHandler.state == .connected {
                if multipeerHandler.coupleReadyAt == "dashboard" {
                    isReady = true
                }
                
                
                let customData = MultipeerData(dataType: .isReadyAt, data: "dashboard".data(using: .utf8))
                
                do {
                    let encodedData = try JSONEncoder().encode(customData)
                    
                    multipeerHandler.sendData(encodedData)
                } catch {
                    print("ERROR: \(error.localizedDescription)")
                }
            }
        }
        .onDisappear {
            isReady = false
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(TopicViewModel()) { topic in
            StatefulObjectPreviewView(UserViewModel()) { user in
                StatefulObjectPreviewView(MultipeerHandler()) { multi in
                    DashboardScreen()
                        .environmentObject(topic)
                        .environmentObject(user)
                        .environmentObject(multi)
                }
            }
        }
    }
}
