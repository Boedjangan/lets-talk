//
//  DashboardScreen.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import SwiftUI

struct DashboardScreen: View {
    var body: some View {
        LayoutView(spacing: 40) {
            TalkTimeView(talkTime: 0)
            
            // GreetingView here
            
            ScrollView {
                VStack(spacing: 24) {
                    TopicListView(progress: 0)
                    
                    TopicListView(level: "Level 2", progress: 0.25)
                    
                    TopicListView(level: "Level 3", progress: 0.50)
                }
            }
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreen()
    }
}
