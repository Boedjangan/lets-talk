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
            
           TopicListView()
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreen()
    }
}
