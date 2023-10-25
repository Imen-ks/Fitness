//
//  FetchRequests.swift
//  Fitness
//
//  Created by Imen Ksouri on 22/10/2023.
//

import Foundation
import CoreData

extension CoreDataManager {
    func fetchWorkouts() {
        let request = NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(WorkoutEntity.date), ascending: false)]
        let objects = fetchWorkouts(request: request)
        workouts = objects.compactMap{ nSManagedObjectToWorkout($0) }
    }
    
    func fetchMetrics(predicate: Metric) -> [Metric] {
        switch predicate.type {
        case .distance:
            let request = NSFetchRequest<DistanceEntity>(entityName: "DistanceEntity")
            request.predicate = NSPredicate(format: "%K == %@",
                                        #keyPath(DistanceEntity.type), predicate.type.rawValue)
            let objects = fetchDistances(request: request)
            return objects.compactMap{ nSManagedObjectToMetric($0) }
        case .speed:
            let request = NSFetchRequest<SpeedEntity>(entityName: "SpeedEntity")
            request.predicate = NSPredicate(format: "%K == %@",
                                        #keyPath(SpeedEntity.type), predicate.type.rawValue)
            let objects = fetchSpeeds(request: request)
            return objects.compactMap{ nSManagedObjectToMetric($0) }
        case .step:
            let request = NSFetchRequest<StepEntity>(entityName: "StepEntity")
            request.predicate = NSPredicate(format: "%K == %@",
                                        #keyPath(StepEntity.type), predicate.type.rawValue)
            let objects = fetchSteps(request: request)
            return objects.compactMap{ nSManagedObjectToMetric($0) }
        case .calorie:
            let request = NSFetchRequest<CalorieEntity>(entityName: "CalorieEntity")
            request.predicate = NSPredicate(format: "%K == %@",
                                        #keyPath(CalorieEntity.type), predicate.type.rawValue)
            let objects = fetchCalories(request: request)
            return objects.compactMap{ nSManagedObjectToMetric($0) }
        }
    }

    internal func getWorkout(withId worKoutId: UUID) -> [WorkoutEntity] {
        let request = NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(WorkoutEntity.id), worKoutId as NSUUID)
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return [WorkoutEntity]()
    }

    internal func fetchWorkouts(request: NSFetchRequest<WorkoutEntity>) -> [WorkoutEntity] {
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return []
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

    internal func fetchDistances(request: NSFetchRequest<DistanceEntity>) -> [DistanceEntity] {
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return []
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

    internal func fetchSpeeds(request: NSFetchRequest<SpeedEntity>) -> [SpeedEntity] {
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return []
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

    internal func fetchSteps(request: NSFetchRequest<StepEntity>) -> [StepEntity] {
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return []
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

    internal func fetchCalories(request: NSFetchRequest<CalorieEntity>) -> [CalorieEntity] {
        do {
            return try persistenceController.container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return []
    }

    internal func workoutToNSManagedObject(_ workout: Workout) -> NSManagedObject {
        let request = getWorkout(withId: workout.id)
        return request.first ?? WorkoutEntity()
    }

    internal func metricToNSManagedObject(_ measure: Measure, metricId: UUID) -> NSManagedObject {
        switch measure {
        case .distance:
            let request = getDistance(for: metricId)
            return request.first ?? DistanceEntity()
        case .speed:
            let request = getSpeed(for: metricId)
            return request.first ?? SpeedEntity()
        case .step:
            let request = getSteps(for: metricId)
            return request.first ?? StepEntity()
        case .calorie:
            let request = getCalories(for: metricId)
            return request.first ?? CalorieEntity()
        }
    }

    internal func nSManagedObjectToWorkout(_ object: NSManagedObject) -> Workout? {
        if object is WorkoutEntity {
            let workoutEntity = object as! WorkoutEntity
//            let distanceEntity = metricToNSManagedObject(.distance, metricId: workoutEntity.id)
//            let speedEntity = metricToNSManagedObject(.speed, metricId: workoutEntity.id)
//            let stepEntity = metricToNSManagedObject(.step, metricId: workoutEntity.id)
//            let calorieEntity = metricToNSManagedObject(.calorie, metricId: workoutEntity.id)
            let workout = Workout(
                id: workoutEntity.id,
                date: workoutEntity.date,
                type: WorkoutType(rawValue: workoutEntity.type),
                route: workoutEntity.route,
                duration: workoutEntity.duration,
                distance: nil /*nSManagedObjectToMetric(distanceEntity) as? Distance*/,
                speed: nil /*nSManagedObjectToMetric(speedEntity) as? Speed*/,
                distances: workoutEntity.distances,
                speeds: workoutEntity.speeds,
                altitudes: workoutEntity.altitudes,
                steps: nil /*nSManagedObjectToMetric(stepEntity) as? Step*/,
                calories: nil /*nSManagedObjectToMetric(calorieEntity) as? Calorie*/
            )
            return workout
        }
        return nil
    }

    internal func nSManagedObjectToMetric(_ object: NSManagedObject) -> Metric? {
        if object is DistanceEntity {
            let distanceEntity = object as! DistanceEntity
            let distance = Distance(
                id: distanceEntity.id,
                workoutType: WorkoutType(rawValue: distanceEntity.workoutType),
                date: distanceEntity.date,
                measure: distanceEntity.measure ?? .init(value: 0, unit: .meters)
            )
            return distance
        }
        if object is SpeedEntity {
            let speedEntity = object as! SpeedEntity
            let speed = Speed(
                id: speedEntity.id,
                workoutType: WorkoutType(rawValue: speedEntity.workoutType),
                date: speedEntity.date,
                measure: speedEntity.measure ?? .init(value: 0, unit: .metersPerSecond)
            )
            return speed
        }
        if object is StepEntity {
            let stepEntity = object as! StepEntity
            let steps = Step(
                id: stepEntity.id,
                workoutType: WorkoutType(rawValue: stepEntity.workoutType),
                date: stepEntity.date,
                count: Int(stepEntity.count)
            )
            return steps
        }
        if object is CalorieEntity {
            let calorieEntity = object as! CalorieEntity
            let calories = Calorie(
                id: calorieEntity.id,
                workoutType: WorkoutType(rawValue: calorieEntity.workoutType),
                date: calorieEntity.date,
                count: Int(calorieEntity.count)
            )
            return calories
        }
        return nil
    }
}
