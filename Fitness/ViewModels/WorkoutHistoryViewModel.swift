//
//  WorkoutHistoryViewModel.swift
//  Fitness
//
//  Created by Imen Ksouri on 08/10/2023.
//

import Foundation
import CoreData
import Combine

@MainActor
final class WorkoutHistoryViewModel: ObservableObject {
    private let dataManager: CoreDataManager
    @Published var filteredType: FilteredWorkoutType = .all
    @Published var filteredWorkouts: [Workout] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init(dataManager: CoreDataManager = .shared) {
        self.dataManager = dataManager
        dataManager.$filteredWorkouts
            .sink { [weak self] in
                self?.filteredWorkouts = $0.map({ dataManager.nSManagedObjectToWorkout($0) })
            }
            .store(in: &cancellables)
    }

    func filterWorkouts() {
        dataManager.filterWorkouts(predicate: filteredType)
    }

    func delete(_ workout: Workout) {
        dataManager.delete(dataManager.workoutToNSManagedObject(workout))
        filterWorkouts()
        if let index = filteredWorkouts.firstIndex(where: { $0.id == workout.id }) {
            filteredWorkouts.remove(at: index)
        }
    }
}
