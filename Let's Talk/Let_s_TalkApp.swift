//
//  Let_s_TalkApp.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 11/07/23.
//

import SwiftUI

@main
struct Let_s_TalkApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
