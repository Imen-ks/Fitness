//
//  FitnessApp.swift
//  Fitness
//
//  Created by Imen Ksouri on 01/10/2023.
//

import SwiftUI

@main
struct FitnessApp: App {
    private let dataManager: CoreDataManager = .shared

    var body: some Scene {
        WindowGroup {
            TabBarView(dataManager: dataManager)
        }
    }
}
