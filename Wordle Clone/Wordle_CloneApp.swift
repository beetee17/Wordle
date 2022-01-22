//
//  Wordle_CloneApp.swift
//  Wordle Clone
//
//  Created by Brandon Thio on 22/1/22.
//

import SwiftUI

@main
struct Wordle_CloneApp: App {
    let persistenceController = PersistenceController.shared
    let viewModel = WordleViewModel()
    init() {
        // register "default defaults"
        UserDefaults.standard.register(defaults: [
            "Current Win Streak" : 0,
            "Previous Best" : 0
            
            // ... other settings
        ])
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewModel)
            
        }
    }
}
