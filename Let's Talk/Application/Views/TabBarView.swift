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
    
    @StateObject var topicVM: TopicViewModel
    @StateObject var questionVM: QuestionViewModel
    @StateObject var loveLogVM: LoveLogViewModel
    
    init(dashboardNavigation: DashboardNavigationManager, loveLogNavigation: LoveLogNavigationManager, userVM: UserViewModel, multipeerHandler: MultipeerHandler) {
        self.dashboardNavigation = dashboardNavigation
        self.loveLogNavigation = loveLogNavigation
        self.userVM = userVM
        self.multipeerHandler = multipeerHandler
        
        _topicVM =  StateObject(wrappedValue: TopicViewModel())
        _questionVM = StateObject(wrappedValue: QuestionViewModel())
        _loveLogVM = StateObject(wrappedValue: LoveLogViewModel())
    }
    
    var body: some View {
        TabView{
            NavigationStack(path: $dashboardNavigation.navigationPaths) {
                DashboardScreen()
                    .navigationDestination(for: DashboardRoutes.self) { routes in
                        switch(routes) {
                        case .dashboard:
                            DashboardScreen()
                        case .warmup:
                            WarmUpScreen()
                        case .warmup_result:
                            WarmUpCorrectScreen(userVM: userVM)
                        case .question_sender:
                            SenderQuestionScreen()
                        case .question_receiver:
                            ReceiverQuestionScreen()
                        case .add_media:
                            AddQuestionMediaScreen(questionVM: questionVM, questionId: UUID())
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
            .environmentObject(loveLogVM)
        }
        .accentColor(Color.buttonPrimary)
        .onAppear() {
            UITabBar.appearance().barTintColor = UIColor(Color.tabBar)
            UITabBar.appearance().backgroundColor = UIColor(Color.tabBar)
            multipeerHandler.startBrowsing()
            multipeerHandler.advertiser.startAdvertisingPeer()
            multipeerHandler.coupleID = userVM.user.coupleId
           }
        .onDisappear(){
            multipeerHandler.stopBrowsing()
            multipeerHandler.advertiser.stopAdvertisingPeer()
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
