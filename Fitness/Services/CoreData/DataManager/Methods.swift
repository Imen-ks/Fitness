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
    func add(_ workout: Workout) {
        let newWorkout = WorkoutEntity(context: persistenceController.container.viewContext)
        newWorkout.id = workout.id
        newWorkout.date = workout.date
        newWorkout.type = workout.type?.rawValue ?? 0
        newWorkout.route = workout.route
        newWorkout.duration = workout.duration
        newWorkout.distances = workout.distances
        newWorkout.speeds = workout.speeds
        newWorkout.altitudes = workout.altitudes
        let distanceForNewWorkout = DistanceEntity(context: persistenceController.container.viewContext)
        distanceForNewWorkout.id = workout.id
        distanceForNewWorkout.workoutType = workout.distance?.workoutType?.rawValue ?? 0
        distanceForNewWorkout.date = workout.distance?.date
        distanceForNewWorkout.type = Measure.distance.rawValue
//        distanceForNewWorkout.measure = workout.distance?.measure
        let speedForNewWorkout = SpeedEntity(context: persistenceController.container.viewContext)
        speedForNewWorkout.id = workout.id
        speedForNewWorkout.workoutType = workout.speed?.workoutType?.rawValue ?? 0
        speedForNewWorkout.date = workout.speed?.date
        speedForNewWorkout.type = Measure.speed.rawValue
//        speedForNewWorkout.measure = workout.speed?.measure
        let stepsForNewWorkout = StepEntity(context: persistenceController.container.viewContext)
        stepsForNewWorkout.id = workout.id
        stepsForNewWorkout.workoutType = workout.steps?.workoutType?.rawValue ?? 0
        stepsForNewWorkout.date = workout.steps?.date
        stepsForNewWorkout.type = Measure.step.rawValue
        stepsForNewWorkout.count = Int16(workout.steps?.count ?? 0)
        let caloriesForNewWorkout = StepEntity(context: persistenceController.container.viewContext)
        caloriesForNewWorkout.id = workout.id
        caloriesForNewWorkout.workoutType = workout.calories?.workoutType?.rawValue ?? 0
        caloriesForNewWorkout.type = Measure.calorie.rawValue
        caloriesForNewWorkout.date = workout.calories?.date
        caloriesForNewWorkout.count = Int16(workout.calories?.count ?? 0)
        save()
    }

    func delete(_ workout: Workout) {
        delete(workoutToNSManagedObject(workout))
    }

    func filterWorkouts(by type: FilteredWorkoutType) {
        self.filteredworkouts = workouts
        switch type {
        case .all:
            self.filteredworkouts = workouts
        case .running:
            self.filteredworkouts = workouts.filter { $0.type == .running }
        case .walking:
            self.filteredworkouts = workouts.filter { $0.type == .walking }
        case .cycling:
            self.filteredworkouts = workouts.filter { $0.type == .cycling }
        }
    }
}
