//
//  DashboardScreen.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import SwiftUI

struct DashboardScreen: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var topicVM: TopicViewModel
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    
    var body: some View {
        LayoutView(spacing: 40) {
            if !multipeerHandler.isCoupleReady {
                LoadingView()
            }
           
            if multipeerHandler.isCoupleReady {
                TalkTimeView(talkTime: userVM.user.talkDuration ?? 0)
                
                GreetingView(userName: userVM.user.username)
                
                TopicListView(topics: topicVM.topics)
            }
        }
        .onAppear {
            let customData = MultipeerData.isReadyData
            
            do {
                let encodedData = try JSONEncoder().encode(customData)
                
                multipeerHandler.sendData(encodedData)
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
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
