//
//  FitnessApp.swift
//  Fitness
//
//  Created by Imen Ksouri on 01/10/2023.
//

import SwiftUI

@main
struct FitnessApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
