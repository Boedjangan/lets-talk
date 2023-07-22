//
//  LoveLogRoutes.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 21/07/23.
//

import SwiftUI

enum LoveLogRoutes: Hashable {
    case lovelog
}

class LoveLogNavigationManager: ObservableObject {
    @Published var navigationPaths = NavigationPath()
    
    func push(to route: LoveLogRoutes) {
        navigationPaths.append(route)
    }
    
    func goBack()  {
        navigationPaths.removeLast()
    }
    
    func reset() {
        navigationPaths = NavigationPath()
    }
}
