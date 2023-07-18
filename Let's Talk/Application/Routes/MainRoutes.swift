//
//  MainRoutes.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

enum MainRoutes: Hashable {
    case a
    case b
}

class MainNavigationManager: ObservableObject{
    @Published var navigationPaths = NavigationPath()
    
    func push(to route: MainRoutes) {
        navigationPaths.append(route)
    }
    
    func goBack()  {
        navigationPaths.removeLast()
    }
    
    func reset() {
        navigationPaths = NavigationPath()
    }
}
