//
//  TabBarView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView{
            DashboardScreen()
                .tabItem{
                    Label("Test",systemImage: "heart.circle.fill")
                }
            LoveLogScreen()
                .tabItem{
                    Label("Love Log",systemImage: "calendar.circle")
                }
        }
        .accentColor(Color.buttonPrimary)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
