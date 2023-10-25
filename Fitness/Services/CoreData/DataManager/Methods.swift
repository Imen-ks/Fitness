//
//  Methods.swift
//  Fitness
//
//  Created by Imen Ksouri on 22/10/2023.
//

import Foundation
import CoreData
import CoreLocation

extension CoreDataManager {
    func delete(_ object: NSManagedObject?) {
        if let object {
            persistenceController.container.viewContext.delete(object)
            save()
        }
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
        fetchDistance()
        fetchSpeed()
        fetchCalories()
        fetchSteps()
    }

    func add(_ workout: Workout) {
        let newWorkout = WorkoutEntity(context: persistenceController.container.viewContext)
        newWorkout.uuid = workout.id
        newWorkout.date = workout.date
        newWorkout.type = workout.type?.rawValue ?? 0
        newWorkout.routeLatitudes = workout.route.map({ $0.map { $0.coordinate.latitude }})
        newWorkout.routeLongitudes = workout.route.map({ $0.map { $0.coordinate.longitude }})
        newWorkout.duration = workout.duration
        newWorkout.distances = workout.distances.map({ $0.map { $0.value }})
        newWorkout.speeds = workout.speeds.map({ $0.map { $0.value } })
        newWorkout.altitudes = workout.altitudes.map({ $0.map { $0.value }})
        save()
    }

    func addMetrics(to workout: Workout) {
        if let newWorkout = getWorkout(withId: workout.id).first {
            addDistance(to: newWorkout, measure: workout.distance?.measure)
            addSpeed(to: newWorkout, measure: workout.speed?.measure)
            addCalories(to: newWorkout, count: workout.calories?.count)
            addSteps(to: newWorkout, count: workout.steps?.count)
        }
    }

    private func addDistance(to workout: WorkoutEntity, measure: Measurement<UnitLength>?) {
        let distance = DistanceEntity(context: persistenceController.container.viewContext)
        distance.id = workout.uuid
        distance.workoutType = workout.type
        distance.date = workout.date
        distance.type = Measure.distance.rawValue
        distance.measure = measure?.value ?? 0
        distance.workout = workout
        workout.distance = distance
        save()
    }

    private func addSpeed(to workout: WorkoutEntity, measure: Measurement<UnitSpeed>?) {
        let speed = SpeedEntity(context: persistenceController.container.viewContext)
        speed.id = workout.uuid
        speed.workoutType = workout.type
        speed.date = workout.date
        speed.type = Measure.speed.rawValue
        speed.measure = measure?.value ?? 0
        speed.workout = workout
        workout.speed = speed
        save()
    }
    
    private func addCalories(to workout: WorkoutEntity, count: Int?) {
        let calories = CalorieEntity(context: persistenceController.container.viewContext)
        calories.id = workout.uuid
        calories.workoutType = workout.type
        calories.date = workout.date
        calories.type = Measure.calorie.rawValue
        calories.count = Int16(count ?? 0)
        calories.workout = workout
        workout.calories = calories
        save()
    }

    private func addSteps(to workout: WorkoutEntity, count: Int?) {
        let steps = StepEntity(context: persistenceController.container.viewContext)
        steps.id = workout.uuid
        steps.workoutType = workout.type
        steps.date = workout.date
        steps.type = Measure.step.rawValue
        steps.count = Int16(count ?? 0)
        steps.workout = workout
        workout.steps = steps
        save()
    }
}

// MARK: Methods for conversion
extension CoreDataManager {
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

    internal func nSManagedObjectToWorkout(_ workout: WorkoutEntity) -> Workout {
        var route: [CLLocation] {
            var route: [CLLocation] = []
            zip(workout.routeLatitudes ?? [], workout.routeLongitudes ?? []).forEach({ route.append(CLLocation.init(latitude: $0, longitude: $1))})
            return route
        }
        let workout = Workout(
            id: workout.uuid,
            date: workout.date,
            type: WorkoutType(rawValue: workout.type),
            route: route,
            duration: workout.duration,
            distance: workout.distance != nil ? nSManagedObjectToMetric(workout.distance!) as? Distance : nil,
            speed: workout.speed != nil ? nSManagedObjectToMetric(workout.speed!) as? Speed : nil,
            distances: workout.distances.map({ $0.map({ Measurement.init(value: $0, unit: .meters )})}),
            speeds: workout.speeds.map({ $0.map({ Measurement.init(value: $0, unit: .metersPerSecond )})}),
            altitudes: workout.altitudes.map({ $0.map({ Measurement.init(value: $0, unit: .meters )})}),
            steps: workout.steps != nil ? nSManagedObjectToMetric(workout.steps!) as? Step : nil,
            calories: workout.calories != nil ? nSManagedObjectToMetric(workout.calories!) as? Calorie : nil
        )
        return workout
    }

    internal func nSManagedObjectToMetric(_ object: NSManagedObject) -> Metric? {
        if object is DistanceEntity {
            let distanceEntity = object as! DistanceEntity
            let distance = Distance(
                id: distanceEntity.id,
                workoutType: WorkoutType(rawValue: distanceEntity.workoutType),
                date: distanceEntity.date,
                measure: Measurement.init(
                    value: distanceEntity.measure, unit: .meters)
            )
            return distance
        }
        if object is SpeedEntity {
            let speedEntity = object as! SpeedEntity
            let speed = Speed(
                id: speedEntity.id,
                workoutType: WorkoutType(rawValue: speedEntity.workoutType),
                date: speedEntity.date,
                measure: Measurement.init(
                    value: speedEntity.measure, unit: .metersPerSecond)
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
