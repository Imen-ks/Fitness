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

    @Published var workouts: [Workout] = []
    @Published var filteredworkouts: [Workout] = []

    init(type: DataManagerType) {
        switch type {
        case .normal:
            persistenceController = PersistenceController()
        case .preview:
            persistenceController = PersistenceController(inMemory: true)
            dataForPreview(persistenceController: persistenceController)
        case .testing:
            persistenceController = PersistenceController(inMemory: true)
        }
        fetchWorkouts()
    }
}

extension CoreDataManager {
    func delete(_ object: NSManagedObject) {
        persistenceController.container.viewContext.delete(object)
        save()
    }

    func save() {
        if persistenceController.container.viewContext.hasChanges {
            do {
                try persistenceController.container.viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        fetchWorkouts()
    }
}
