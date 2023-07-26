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
    
    var body: some View {
        LayoutView(spacing: 40) {
            TalkTimeView(talkTime: userVM.user.talkDuration ?? 0)
            
            GreetingView(userName: userVM.user.username)
            
            TopicListView(topics: topicVM.topics)
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(TopicViewModel()) { topic in
            StatefulObjectPreviewView(UserViewModel()) { user in
                DashboardScreen()
                    .environmentObject(topic)
                    .environmentObject(user)
            }
        }
    }
}
