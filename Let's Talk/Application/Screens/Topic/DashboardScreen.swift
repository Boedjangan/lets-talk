//
//  DashboardScreen.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import SwiftUI

struct DashboardScreen: View {
    @EnvironmentObject var topicVM : TopicViewModel
    var body: some View {
        LayoutView(spacing: 40) {
            TalkTimeView(talkTime: 0)
            
            // GreetingView here
            
            TopicListView(topics: topicVM.topics)
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(TopicViewModel()) { dash in
            DashboardScreen()
                .environmentObject(dash)
        }
        
        
    }
}
