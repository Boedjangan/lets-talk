//
//  TabBarView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject var dashboardNavigation: DashboardNavigationManager
    @ObservedObject var loveLogNavigation: LoveLogNavigationManager
    
    
    var body: some View {
        TabView{
            NavigationStack(path: $dashboardNavigation.navigationPaths) {
                DashboardScreen()
                    .navigationDestination(for: DashboardRoutes.self) { routes in
                        switch(routes) {
                        case .dashboard:
                            DashboardScreen()
                        case .warmup:
                            DashboardScreen()
                        case .warmup_result:
                            DashboardScreen()
                        case .question_sender:
                            DashboardScreen()
                        case .question_receiver:
                            DashboardScreen()
                        }
                    }
            }
            .tabItem{
                Label("Test",systemImage: "heart.circle.fill")
            }
            
            NavigationStack(path: $dashboardNavigation.navigationPaths) {
                LoveLogScreen()
                    .navigationDestination(for: LoveLogRoutes.self) { routes in
                        switch(routes) {
                        case .lovelog:
                            LoveLogScreen()
                        }
                    }
            }
            .tabItem{
                Label("Love Log",systemImage: "calendar.circle")
            }
        }
        .accentColor(Color.buttonPrimary)
        .onAppear() {
            UITabBar.appearance().barTintColor = UIColor(Color.tabBar)
            UITabBar.appearance().backgroundColor = UIColor(Color.tabBar)
           }
    }
}

struct TabBarView_Previews: PreviewProvider {    
    static var previews: some View {
        StatefulObjectPreviewView(DashboardNavigationManager()) { dash in
            StatefulObjectPreviewView(LoveLogNavigationManager()) { love in
                TabBarView(dashboardNavigation: dash, loveLogNavigation: love)
            }
        }
    }
}
