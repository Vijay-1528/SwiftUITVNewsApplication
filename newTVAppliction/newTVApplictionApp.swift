//
//  newTVApplictionApp.swift
//  newTVAppliction
//
//  Created by VIJAY M on 21/03/23.
//

import SwiftUI

@main
struct newTVApplictionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
