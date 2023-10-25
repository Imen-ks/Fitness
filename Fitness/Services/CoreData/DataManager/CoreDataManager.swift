//
//  CoreDataManager.swift
//  Fitness
//
//  Created by Imen Ksouri on 22/10/2023.
//

import Foundation
import CoreData
import CoreLocation

enum DataManagerType {
    case normal, preview, testing
}

class CoreDataManager: ObservableObject {
    var persistenceController: PersistenceController
    
    static let shared = CoreDataManager(type: .normal)
    static let preview = CoreDataManager(type: .preview)

    @Published var workouts: [WorkoutEntity] = []
    @Published var distances: [DistanceEntity] = []
    @Published var speeds: [SpeedEntity] = []
    @Published var calories: [CalorieEntity] = []
    @Published var steps: [StepEntity] = []
    @Published var filteredWorkouts: [WorkoutEntity] = []

    init(type: DataManagerType) {
        switch type {
        case .normal:
            persistenceController = PersistenceController()
        case .preview:
            persistenceController = PersistenceController(inMemory: true)
            mockData(persistenceController: persistenceController)
        case .testing:
            persistenceController = PersistenceController(inMemory: true)
        }
        fetchWorkouts()
        fetchDistance()
        fetchSpeed()
        fetchCalories()
        fetchSteps()
    }
}
