//
//  TabBarView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject var dashboardNavigation: DashboardNavigationManager
    
    var body: some View {
        TabView{
            NavigationStack(path: $dashboardNavigation.navigationPaths) {
                DashboardScreen()
                    .navigationDestination(for: DashboardRoutes.self) { route in
                        switch(route) {
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
        StatefulObjectPreviewView(DashboardNavigationManager()) { dash in
            TabBarView(dashboardNavigation: dash)
        }
    }
}
