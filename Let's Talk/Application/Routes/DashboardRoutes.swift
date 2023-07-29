//
//  MainRoutes.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

enum DashboardRoutes: Hashable {
    case dashboard
    case warmup
    case warmup_result
    case question_sender
    case question_receiver
    case add_media
    case overview
    case camera
}

class DashboardNavigationManager: ObservableObject {
    @Published var navigationPaths = NavigationPath()
    
    func push(to route: DashboardRoutes) {
        if navigationPaths.count > 0 {
            navigationPaths = NavigationPath([route])
        } else {
            navigationPaths.append(route)
        }
    }
    
    func goBack()  {
        navigationPaths.removeLast()
    }
    
    func reset() {
        navigationPaths = NavigationPath()
    }
}
