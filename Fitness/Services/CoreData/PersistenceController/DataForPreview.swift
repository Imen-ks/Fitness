//
//  DataForPreview.swift
//  Fitness
//
//  Created by Imen Ksouri on 23/10/2023.
//

import Foundation
import CoreLocation
import CoreData

extension PersistenceController {
    static let previewPersistenceController = PersistenceController(inMemory: true)

    static let mockCoords: [CLLocation] = [
        CLLocation(latitude: 37.33418, longitude: -122.01198),
        CLLocation(latitude: 37.33444, longitude: -122.01219),
        CLLocation(latitude: 37.33462, longitude: -122.01234),
        CLLocation(latitude: 37.33474, longitude: -122.01244),
        CLLocation(latitude: 37.33481, longitude: -122.0125),
        CLLocation(latitude: 37.33485, longitude: -122.01254),
        CLLocation(latitude: 37.33489, longitude: -122.0126),
        CLLocation(latitude: 37.33492, longitude: -122.01265),
        CLLocation(latitude: 37.33495, longitude: -122.01272),
        CLLocation(latitude: 37.33499, longitude: -122.01283),
        CLLocation(latitude: 37.33501, longitude: -122.01293),
        CLLocation(latitude: 37.33501, longitude: -122.01301),
        CLLocation(latitude: 37.33502, longitude: -122.0133),
        CLLocation(latitude: 37.33502, longitude: -122.01397),
        CLLocation(latitude: 37.33502, longitude: -122.014),
        CLLocation(latitude: 37.33503, longitude: -122.01417),
        CLLocation(latitude: 37.33514, longitude: -122.01417),
        CLLocation(latitude: 37.33772, longitude: -122.01416),
        CLLocation(latitude: 37.33776, longitude: -122.0054),
        CLLocation(latitude: 37.33447, longitude: -122.00546),
        CLLocation(latitude: 37.33353, longitude: -122.00569),
        CLLocation(latitude: 37.3327, longitude: -122.0059),
        CLLocation(latitude: 37.33038, longitude: -122.00586),
        CLLocation(latitude: 37.3304, longitude: -122.00603),
        CLLocation(latitude: 37.3304, longitude: -122.00619),
        CLLocation(latitude: 37.33035, longitude: -122.00652),
        CLLocation(latitude: 37.33022, longitude: -122.00681),
    ]
    static var cumulatedDistances: [CLLocationDistance] {
        let distances = mockCoords.enumerated().map { $1.distance(from: mockCoords[$0 == 0 ? $0 : $0 - 1]) }
        return distances.enumerated().map { Array(distances[0...$0.0]).reduce(0, +) }
    }

    static var speeds: [CLLocationSpeed] {
        mockCoords.map { _ in CLLocationSpeed.random(in: 2.4..<3.2) }
    }

    static var altitudes: [CLLocationDistance] {
        mockCoords.map { _ in CLLocationDistance.random(in: 48..<52) }
    }

    static func nSManagedObjectToMetric(_ object: NSManagedObject) -> Metric? {
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

    static func nSManagedObjectToWorkout(
        _ workout: WorkoutEntity,
        _ distance: DistanceEntity,
        _ speed: SpeedEntity,
        _ steps: StepEntity,
        _ calories: CalorieEntity) -> Workout {
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
                distance: nSManagedObjectToMetric(distance) as? Distance,
                speed: nSManagedObjectToMetric(speed) as? Speed,
                distances: workout.distances.map({ $0.map({ Measurement.init(value: $0, unit: .meters )})}),
                speeds: workout.speeds.map({ $0.map({ Measurement.init(value: $0, unit: .metersPerSecond )})}),
                altitudes: workout.altitudes.map({ $0.map({ Measurement.init(value: $0, unit: .meters )})}),
                steps: nSManagedObjectToMetric(steps) as? Step,
                calories: nSManagedObjectToMetric(calories) as? Calorie
            )
            return workout
    }

    static func getWorkoutForPreview(persistenceController: PersistenceController) -> Workout {
        // MARK: - WORKOUT FOR PREVIEW
        let idForMockWorkout = UUID()
        let mockWorkout = WorkoutEntity(context: persistenceController.container.viewContext)
        mockWorkout.uuid = idForMockWorkout
        mockWorkout.date = Date.now
        mockWorkout.type = 0
        mockWorkout.routeLatitudes = PersistenceController.mockCoords.map({ $0.coordinate.latitude })
        mockWorkout.routeLongitudes = PersistenceController.mockCoords.map({ $0.coordinate.longitude })
        mockWorkout.duration = 895
        mockWorkout.distances = PersistenceController.cumulatedDistances
            .map { $0 }
        mockWorkout.speeds = PersistenceController.mockCoords
            .map { _ in CLLocationSpeed.random(in: 2.4..<3.2) }
            .map { $0 }
        mockWorkout.altitudes = PersistenceController.mockCoords
            .map { _ in CLLocationDistance.random(in: 48..<52) }
            .map { $0 }
        let distanceForMockWorkout = DistanceEntity(context: persistenceController.container.viewContext)
        distanceForMockWorkout.id = idForMockWorkout
        distanceForMockWorkout.workoutType = 0
        distanceForMockWorkout.date = Date.now
        distanceForMockWorkout.measure = 2488
        let speedForMockWorkout = SpeedEntity(context: persistenceController.container.viewContext)
        speedForMockWorkout.id = idForMockWorkout
        speedForMockWorkout.workoutType = 0
        speedForMockWorkout.date = Date.now
        speedForMockWorkout.measure = 2.78
        let stepsForMockWorkout = StepEntity(context: persistenceController.container.viewContext)
        stepsForMockWorkout.id = idForMockWorkout
        stepsForMockWorkout.workoutType = 0
        stepsForMockWorkout.date = Date.now
        stepsForMockWorkout.count = 5000
        let caloriesForMockWorkout = CalorieEntity(context: persistenceController.container.viewContext)
        caloriesForMockWorkout.id = idForMockWorkout
        caloriesForMockWorkout.workoutType = 0
        caloriesForMockWorkout.date = Date.now
        caloriesForMockWorkout.count = 175
        mockWorkout.distance = distanceForMockWorkout
        mockWorkout.speed = speedForMockWorkout
        mockWorkout.calories = caloriesForMockWorkout
        mockWorkout.steps = stepsForMockWorkout
        distanceForMockWorkout.workout = mockWorkout
        speedForMockWorkout.workout = mockWorkout
        caloriesForMockWorkout.workout = mockWorkout
        stepsForMockWorkout.workout = mockWorkout
        return nSManagedObjectToWorkout(mockWorkout, distanceForMockWorkout,
                                        speedForMockWorkout, stepsForMockWorkout,
                                        caloriesForMockWorkout)
    }
}
