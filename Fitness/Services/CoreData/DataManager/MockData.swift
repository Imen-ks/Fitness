//
//  DataForPreview.swift
//  Fitness
//
//  Created by Imen Ksouri on 22/10/2023.
//

import Foundation
import CoreLocation

extension CoreDataManager {
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

    func mockData(persistenceController: PersistenceController) {
        getWorkout1(persistenceController: persistenceController)
        getWorkout2(persistenceController: persistenceController)
        getWorkout3(persistenceController: persistenceController)
        getWorkout4(persistenceController: persistenceController)
        getWorkout5(persistenceController: persistenceController)
        getWorkout6(persistenceController: persistenceController)
    }

    func getWorkout1(persistenceController: PersistenceController) {
        // MARK: - WORKOUT #1
        let idForMockWorkout = UUID()
        let mockWorkout = WorkoutEntity(context: persistenceController.container.viewContext)
        mockWorkout.uuid = idForMockWorkout
        mockWorkout.date = Date.now
        mockWorkout.type = WorkoutType.running.rawValue
        mockWorkout.routeLatitudes = CoreDataManager.mockCoords.map({ $0.coordinate.latitude })
        mockWorkout.routeLongitudes = CoreDataManager.mockCoords.map({ $0.coordinate.longitude })
        mockWorkout.duration = 895
        mockWorkout.distances = CoreDataManager.cumulatedDistances
            .map { $0 }
        mockWorkout.speeds = CoreDataManager.mockCoords
            .map { _ in CLLocationSpeed.random(in: 2.4..<3.2) }
            .map { $0 }
        mockWorkout.altitudes = CoreDataManager.mockCoords
            .map { _ in CLLocationDistance.random(in: 48..<52) }
            .map { $0 }
        let distanceForMockWorkout = DistanceEntity(context: persistenceController.container.viewContext)
        distanceForMockWorkout.id = idForMockWorkout
        distanceForMockWorkout.workoutType = Int16(0)
        distanceForMockWorkout.date = Date.now
        distanceForMockWorkout.measure = 2488
        let speedForMockWorkout = SpeedEntity(context: persistenceController.container.viewContext)
        speedForMockWorkout.id = idForMockWorkout
        speedForMockWorkout.workoutType = WorkoutType.running.rawValue
        speedForMockWorkout.date = Date.now
        speedForMockWorkout.measure = 2.78
        let stepsForMockWorkout = StepEntity(context: persistenceController.container.viewContext)
        stepsForMockWorkout.id = idForMockWorkout
        stepsForMockWorkout.workoutType = WorkoutType.running.rawValue
        stepsForMockWorkout.date = Date.now
        stepsForMockWorkout.count = 5000
        let caloriesForMockWorkout = CalorieEntity(context: persistenceController.container.viewContext)
        caloriesForMockWorkout.id = idForMockWorkout
        caloriesForMockWorkout.workoutType = WorkoutType.running.rawValue
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
    }

    func getWorkout2(persistenceController: PersistenceController) {
        // MARK: - WORKOUT #2
        let idForMockWorkout = UUID()
        let mockWorkout = WorkoutEntity(context: persistenceController.container.viewContext)
        mockWorkout.uuid = idForMockWorkout
        mockWorkout.date = Date.now.addingTimeInterval(-86400)
        mockWorkout.type = WorkoutType.cycling.rawValue
        mockWorkout.routeLatitudes = CoreDataManager.mockCoords.map({ $0.coordinate.latitude })
        mockWorkout.routeLongitudes = CoreDataManager.mockCoords.map({ $0.coordinate.longitude })
        mockWorkout.duration = 938
        mockWorkout.distances = CoreDataManager.cumulatedDistances
            .map { $0 }
        mockWorkout.speeds = CoreDataManager.mockCoords
            .map { _ in CLLocationSpeed.random(in: 5.2..<6.0) }
            .map { $0 }
        mockWorkout.altitudes = CoreDataManager.mockCoords
            .map { _ in CLLocationDistance.random(in: 48..<52) }
            .map { $0 }
        let distanceForMockWorkout = DistanceEntity(context: persistenceController.container.viewContext)
        distanceForMockWorkout.id = idForMockWorkout
        distanceForMockWorkout.workoutType = WorkoutType.cycling.rawValue
        distanceForMockWorkout.date = Date.now.addingTimeInterval(-86400)
        distanceForMockWorkout.measure = 5200
        let speedForMockWorkout = SpeedEntity(context: persistenceController.container.viewContext)
        speedForMockWorkout.id = idForMockWorkout
        speedForMockWorkout.workoutType = WorkoutType.cycling.rawValue
        speedForMockWorkout.date = Date.now.addingTimeInterval(-86400)
        speedForMockWorkout.measure = 5.54
        let stepsForMockWorkout = StepEntity(context: persistenceController.container.viewContext)
        stepsForMockWorkout.id = idForMockWorkout
        stepsForMockWorkout.workoutType = WorkoutType.cycling.rawValue
        stepsForMockWorkout.date = Date.now.addingTimeInterval(-86400)
        stepsForMockWorkout.count = 0
        let caloriesForMockWorkout = CalorieEntity(context: persistenceController.container.viewContext)
        caloriesForMockWorkout.id = idForMockWorkout
        caloriesForMockWorkout.workoutType = WorkoutType.cycling.rawValue
        caloriesForMockWorkout.date = Date.now.addingTimeInterval(-86400)
        caloriesForMockWorkout.count = 130
        mockWorkout.distance = distanceForMockWorkout
        mockWorkout.speed = speedForMockWorkout
        mockWorkout.calories = caloriesForMockWorkout
        mockWorkout.steps = stepsForMockWorkout
        distanceForMockWorkout.workout = mockWorkout
        speedForMockWorkout.workout = mockWorkout
        caloriesForMockWorkout.workout = mockWorkout
        stepsForMockWorkout.workout = mockWorkout
    }

    func getWorkout3(persistenceController: PersistenceController) {
        // MARK: - WORKOUT #3
        let idForMockWorkout = UUID()
        let mockWorkout = WorkoutEntity(context: persistenceController.container.viewContext)
        mockWorkout.uuid = idForMockWorkout
        mockWorkout.date = Date.now.addingTimeInterval(-172800)
        mockWorkout.type = WorkoutType.walking.rawValue
        mockWorkout.routeLatitudes = CoreDataManager.mockCoords.map({ $0.coordinate.latitude })
        mockWorkout.routeLongitudes = CoreDataManager.mockCoords.map({ $0.coordinate.longitude })
        mockWorkout.duration = 1800
        mockWorkout.distances = CoreDataManager.cumulatedDistances
            .map { $0 }
        mockWorkout.speeds = CoreDataManager.mockCoords
            .map { _ in CLLocationSpeed.random(in: 1.3..<2.1) }
            .map { $0 }
        mockWorkout.altitudes = CoreDataManager.mockCoords
            .map { _ in CLLocationDistance.random(in: 48..<52) }
            .map { $0 }
        let distanceForMockWorkout = DistanceEntity(context: persistenceController.container.viewContext)
        distanceForMockWorkout.id = idForMockWorkout
        distanceForMockWorkout.workoutType = WorkoutType.walking.rawValue
        distanceForMockWorkout.date = Date.now.addingTimeInterval(-172800)
        distanceForMockWorkout.measure = 3000
        let speedForMockWorkout = SpeedEntity(context: persistenceController.container.viewContext)
        speedForMockWorkout.id = idForMockWorkout
        speedForMockWorkout.workoutType = WorkoutType.walking.rawValue
        speedForMockWorkout.date = Date.now.addingTimeInterval(-172800)
        speedForMockWorkout.measure = 1.67
        let stepsForMockWorkout = StepEntity(context: persistenceController.container.viewContext)
        stepsForMockWorkout.id = idForMockWorkout
        stepsForMockWorkout.workoutType = WorkoutType.walking.rawValue
        stepsForMockWorkout.date = Date.now.addingTimeInterval(-172800)
        stepsForMockWorkout.count = 3100
        let caloriesForMockWorkout = CalorieEntity(context: persistenceController.container.viewContext)
        caloriesForMockWorkout.id = idForMockWorkout
        caloriesForMockWorkout.workoutType = WorkoutType.walking.rawValue
        caloriesForMockWorkout.date = Date.now.addingTimeInterval(-172800)
        caloriesForMockWorkout.count = 165
        mockWorkout.distance = distanceForMockWorkout
        mockWorkout.speed = speedForMockWorkout
        mockWorkout.calories = caloriesForMockWorkout
        mockWorkout.steps = stepsForMockWorkout
        distanceForMockWorkout.workout = mockWorkout
        speedForMockWorkout.workout = mockWorkout
        caloriesForMockWorkout.workout = mockWorkout
        stepsForMockWorkout.workout = mockWorkout
    }

    func getWorkout4(persistenceController: PersistenceController) {
        // MARK: - WORKOUT #4
        let idForMockWorkout = UUID()
        let mockWorkout = WorkoutEntity(context: persistenceController.container.viewContext)
        mockWorkout.uuid = idForMockWorkout
        mockWorkout.date = Date.now.addingTimeInterval(-259200)
        mockWorkout.type = WorkoutType.running.rawValue
        mockWorkout.routeLatitudes = CoreDataManager.mockCoords.map({ $0.coordinate.latitude })
        mockWorkout.routeLongitudes = CoreDataManager.mockCoords.map({ $0.coordinate.longitude })
        mockWorkout.duration = 2450
        mockWorkout.distances = CoreDataManager.cumulatedDistances
            .map { $0 }
        mockWorkout.speeds = CoreDataManager.mockCoords
            .map { _ in CLLocationSpeed.random(in: 2.3..<3.1) }
            .map { $0 }
        mockWorkout.altitudes = CoreDataManager.mockCoords
            .map { _ in CLLocationDistance.random(in: 48..<52) }
            .map { $0 }
        let distanceForMockWorkout = DistanceEntity(context: persistenceController.container.viewContext)
        distanceForMockWorkout.id = idForMockWorkout
        distanceForMockWorkout.workoutType = WorkoutType.running.rawValue
        distanceForMockWorkout.date = Date.now.addingTimeInterval(-259200)
        distanceForMockWorkout.measure = 6640
        let speedForMockWorkout = SpeedEntity(context: persistenceController.container.viewContext)
        speedForMockWorkout.id = idForMockWorkout
        speedForMockWorkout.workoutType = WorkoutType.running.rawValue
        speedForMockWorkout.date = Date.now.addingTimeInterval(-259200)
        speedForMockWorkout.measure = 2.71
        let stepsForMockWorkout = StepEntity(context: persistenceController.container.viewContext)
        stepsForMockWorkout.id = idForMockWorkout
        stepsForMockWorkout.workoutType = WorkoutType.running.rawValue
        stepsForMockWorkout.date = Date.now.addingTimeInterval(-259200)
        stepsForMockWorkout.count = 13320
        let caloriesForMockWorkout = CalorieEntity(context: persistenceController.container.viewContext)
        caloriesForMockWorkout.id = idForMockWorkout
        caloriesForMockWorkout.workoutType = WorkoutType.running.rawValue
        caloriesForMockWorkout.date = Date.now.addingTimeInterval(-259200)
        caloriesForMockWorkout.count = 465
        mockWorkout.distance = distanceForMockWorkout
        mockWorkout.speed = speedForMockWorkout
        mockWorkout.calories = caloriesForMockWorkout
        mockWorkout.steps = stepsForMockWorkout
        distanceForMockWorkout.workout = mockWorkout
        speedForMockWorkout.workout = mockWorkout
        caloriesForMockWorkout.workout = mockWorkout
        stepsForMockWorkout.workout = mockWorkout
    }

    func getWorkout5(persistenceController: PersistenceController) {
        // MARK: - WORKOUT #5
        let idForMockWorkout = UUID()
        let mockWorkout = WorkoutEntity(context: persistenceController.container.viewContext)
        mockWorkout.uuid = idForMockWorkout
        mockWorkout.date = Date.now.addingTimeInterval(-345600)
        mockWorkout.type = WorkoutType.walking.rawValue
        mockWorkout.routeLatitudes = CoreDataManager.mockCoords.map({ $0.coordinate.latitude })
        mockWorkout.routeLongitudes = CoreDataManager.mockCoords.map({ $0.coordinate.longitude })
        mockWorkout.duration = 4505
        mockWorkout.distances = CoreDataManager.cumulatedDistances
            .map { $0 }
        mockWorkout.speeds = CoreDataManager.mockCoords
            .map { _ in CLLocationSpeed.random(in: 1.3..<2.1) }
            .map { $0 }
        mockWorkout.altitudes = CoreDataManager.mockCoords
            .map { _ in CLLocationDistance.random(in: 48..<52) }
            .map { $0 }
        let distanceForMockWorkout = DistanceEntity(context: persistenceController.container.viewContext)
        distanceForMockWorkout.id = idForMockWorkout
        distanceForMockWorkout.workoutType = WorkoutType.walking.rawValue
        distanceForMockWorkout.date = Date.now.addingTimeInterval(-345600)
        distanceForMockWorkout.measure = 7750
        let speedForMockWorkout = SpeedEntity(context: persistenceController.container.viewContext)
        speedForMockWorkout.id = idForMockWorkout
        speedForMockWorkout.workoutType = WorkoutType.walking.rawValue
        speedForMockWorkout.date = Date.now.addingTimeInterval(-345600)
        speedForMockWorkout.measure = 1.72
        let stepsForMockWorkout = StepEntity(context: persistenceController.container.viewContext)
        stepsForMockWorkout.id = idForMockWorkout
        stepsForMockWorkout.workoutType = WorkoutType.walking.rawValue
        stepsForMockWorkout.date = Date.now.addingTimeInterval(-345600)
        stepsForMockWorkout.count = 15000
        let caloriesForMockWorkout = CalorieEntity(context: persistenceController.container.viewContext)
        caloriesForMockWorkout.id = idForMockWorkout
        caloriesForMockWorkout.workoutType = WorkoutType.walking.rawValue
        caloriesForMockWorkout.date = Date.now.addingTimeInterval(-345600)
        caloriesForMockWorkout.count = 426
        mockWorkout.distance = distanceForMockWorkout
        mockWorkout.speed = speedForMockWorkout
        mockWorkout.calories = caloriesForMockWorkout
        mockWorkout.steps = stepsForMockWorkout
        distanceForMockWorkout.workout = mockWorkout
        speedForMockWorkout.workout = mockWorkout
        caloriesForMockWorkout.workout = mockWorkout
        stepsForMockWorkout.workout = mockWorkout
    }

    func getWorkout6(persistenceController: PersistenceController) {
        // MARK: - WORKOUT #6
        let idForMockWorkout = UUID()
        let mockWorkout = WorkoutEntity(context: persistenceController.container.viewContext)
        mockWorkout.uuid = idForMockWorkout
        mockWorkout.date = Date.now.addingTimeInterval(-432000)
        mockWorkout.type = WorkoutType.cycling.rawValue
        mockWorkout.routeLatitudes = CoreDataManager.mockCoords.map({ $0.coordinate.latitude })
        mockWorkout.routeLongitudes = CoreDataManager.mockCoords.map({ $0.coordinate.longitude })
        mockWorkout.duration = 885
        mockWorkout.distances = CoreDataManager.cumulatedDistances
            .map { $0 }
        mockWorkout.speeds = CoreDataManager.mockCoords
            .map { _ in CLLocationSpeed.random(in: 5.4..<6.2) }
            .map { $0 }
        mockWorkout.altitudes = CoreDataManager.mockCoords
            .map { _ in CLLocationDistance.random(in: 48..<52) }
            .map { $0 }
        let distanceForMockWorkout = DistanceEntity(context: persistenceController.container.viewContext)
        distanceForMockWorkout.id = idForMockWorkout
        distanceForMockWorkout.workoutType = WorkoutType.cycling.rawValue
        distanceForMockWorkout.date = Date.now.addingTimeInterval(-432000)
        distanceForMockWorkout.measure = 5150
        let speedForMockWorkout = SpeedEntity(context: persistenceController.container.viewContext)
        speedForMockWorkout.id = idForMockWorkout
        speedForMockWorkout.workoutType = WorkoutType.cycling.rawValue
        speedForMockWorkout.date = Date.now.addingTimeInterval(-432000)
        speedForMockWorkout.measure = 5.82
        let stepsForMockWorkout = StepEntity(context: persistenceController.container.viewContext)
        stepsForMockWorkout.id = idForMockWorkout
        stepsForMockWorkout.workoutType = WorkoutType.cycling.rawValue
        stepsForMockWorkout.date = Date.now.addingTimeInterval(-432000)
        stepsForMockWorkout.count = 0
        let caloriesForMockWorkout = CalorieEntity(context: persistenceController.container.viewContext)
        caloriesForMockWorkout.id = idForMockWorkout
        caloriesForMockWorkout.workoutType = WorkoutType.cycling.rawValue
        caloriesForMockWorkout.date = Date.now.addingTimeInterval(-432000)
        caloriesForMockWorkout.count = 129
        mockWorkout.distance = distanceForMockWorkout
        mockWorkout.speed = speedForMockWorkout
        mockWorkout.calories = caloriesForMockWorkout
        mockWorkout.steps = stepsForMockWorkout
        distanceForMockWorkout.workout = mockWorkout
        speedForMockWorkout.workout = mockWorkout
        caloriesForMockWorkout.workout = mockWorkout
        stepsForMockWorkout.workout = mockWorkout
    }
}
