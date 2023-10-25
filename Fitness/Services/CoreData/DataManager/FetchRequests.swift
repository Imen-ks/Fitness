//
//  FetchRequests.swift
//  Fitness
//
//  Created by Imen Ksouri on 22/10/2023.
//

import Foundation
import CoreData

// MARK: Fetch requests returning all objects for each Entity
extension CoreDataManager {
    func fetchWorkouts() {
        let request = NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(WorkoutEntity.date), ascending: false)]
        do {
            workouts = try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
    }

    func fetchDistance() {
        let request = NSFetchRequest<DistanceEntity>(entityName: "DistanceEntity")
        do {
            distances = try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
    }

    func fetchSpeed() {
        let request = NSFetchRequest<SpeedEntity>(entityName: "SpeedEntity")
        do {
            speeds = try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
    }

    func fetchSteps() {
        let request = NSFetchRequest<StepEntity>(entityName: "StepEntity")
        do {
            steps = try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
    }

    func fetchCalories() {
        let request = NSFetchRequest<CalorieEntity>(entityName: "CalorieEntity")
        do {
            calories = try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
    }
}

// MARK: Fetch requests returning objects for specific Workout
extension CoreDataManager {
    internal func getWorkout(withId worKoutId: UUID) -> [WorkoutEntity] {
        let request = NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(WorkoutEntity.uuid), worKoutId as NSUUID)
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return [WorkoutEntity]()
    }

    internal func getDistance(for worKoutId: UUID) -> [DistanceEntity] {
        let request = NSFetchRequest<DistanceEntity>(entityName: "DistanceEntity")
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(DistanceEntity.id), worKoutId as NSUUID)
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return [DistanceEntity]()
    }

    internal func getSpeed(for worKoutId: UUID) -> [SpeedEntity] {
        let request = NSFetchRequest<SpeedEntity>(entityName: "SpeedEntity")
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(SpeedEntity.id), worKoutId as NSUUID)
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return [SpeedEntity]()
    }

    internal func getSteps(for worKoutId: UUID) -> [StepEntity] {
        let request = NSFetchRequest<StepEntity>(entityName: "StepEntity")
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(StepEntity.id), worKoutId as NSUUID)
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return [StepEntity]()
    }

    internal func getCalories(for worKoutId: UUID) -> [CalorieEntity] {
        let request = NSFetchRequest<CalorieEntity>(entityName: "CalorieEntity")
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(CalorieEntity.id), worKoutId as NSUUID)
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return [CalorieEntity]()
    }
}

// MARK: Fetch requests for filtering Workouts
extension CoreDataManager {
    func fetchWorkouts(request: NSFetchRequest<WorkoutEntity>) -> [WorkoutEntity] {
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return []
    }

    func filterWorkouts(predicate: FilteredWorkoutType) {
        let request = NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(WorkoutEntity.date), ascending: false)]
        if predicate == .running {
            request.predicate = NSPredicate(format: "%K == %i", #keyPath(WorkoutEntity.type), WorkoutType.running.rawValue)
            filteredWorkouts = fetchWorkouts(request: request)
        } else if predicate == .walking {
            request.predicate = NSPredicate(format: "%K == %i", #keyPath(WorkoutEntity.type),  WorkoutType.walking.rawValue)
            filteredWorkouts = fetchWorkouts(request: request)
        } else if predicate == .cycling {
            request.predicate = NSPredicate(format: "%K == %i", #keyPath(WorkoutEntity.type), WorkoutType.cycling.rawValue)
            filteredWorkouts = fetchWorkouts(request: request)
        } else { filteredWorkouts = fetchWorkouts(request: request) }
    }
}
