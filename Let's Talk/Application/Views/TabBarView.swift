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
    @ObservedObject var userVM: UserViewModel
    @ObservedObject var multipeerHandler: MultipeerHandler
    
    @StateObject var topicVM: TopicViewModel = TopicViewModel()
    @StateObject var questionVM: QuestionViewModel = QuestionViewModel()
    
    var body: some View {
        TabView{
            NavigationStack(path: $dashboardNavigation.navigationPaths) {
                DashboardScreen()
                    .navigationDestination(for: DashboardRoutes.self) { routes in
                        switch(routes) {
                        case .dashboard:
                            DashboardScreen()
                        case let .warmup(topicId):
                            WarmUpScreen(topicId: topicId, questionVM: questionVM)
                        case .warmup_result:
                            WarmUpCorrectScreen()
                        case .question_sender:
                            SenderQuestionScreen()
                        case .question_receiver:
                            ReceiverQuestionScreen()
                        case .add_media:
                            AddQuestionMediaScreen()
                        case .overview:
                            QuestionSessionOverviewScreen()
                        }
                    }
            }
            .tabItem{
                Label("Dashboard",systemImage: "heart.circle.fill")
            }
            .environmentObject(topicVM)
            .environmentObject(userVM)
            .environmentObject(questionVM)
            .environmentObject(dashboardNavigation)
            .environmentObject(multipeerHandler)
            
            NavigationStack(path: $loveLogNavigation.navigationPaths) {
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
                StatefulObjectPreviewView(UserViewModel()) { user in
                    StatefulObjectPreviewView(MultipeerHandler()) { multi in
                        TabBarView(dashboardNavigation: dash, loveLogNavigation: love, userVM: user, multipeerHandler: multi)
                    }
                }
            }
        }
    }
}
