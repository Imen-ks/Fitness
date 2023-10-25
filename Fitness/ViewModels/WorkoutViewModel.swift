//
//  WorkoutViewModel.swift
//  Fitness
//
//  Created by Imen Ksouri on 03/10/2023.
//

import Foundation
import CoreLocation

@MainActor
final class WorkoutViewModel: ObservableObject {
    var locationManager = LocationManager()
    var timer = TimerManager()
    var workoutType: WorkoutType?
    @Published var workoutStarted: Bool = false
    @Published var workoutEnded: Bool = false
    @Published var startDate: Date?
    @Published var steps: Int = 0
//    @Published var distances: [CLLocationDistance?] = []
    
    init(type: WorkoutType? = nil) {
        self.workoutType = type
    }

    func beginWorkout() {
        startDate = Date()
        workoutStarted = true
        timer.start()
        locationManager.startLocationServices()
        locationManager.endLocation = nil
    }

    func endWorkout() {
        workoutEnded = true
        timer.stop()
        locationManager.stopLocationServices()
    }
}

struct Workout: Identifiable {
    let id = UUID()
    let date: Date
    let type: WorkoutType
    let route: [CLLocation]
    let duration: TimeInterval
    let distance: Double
    let speed: Double
    let altitude: Double
    let steps: Int
}
