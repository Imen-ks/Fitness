//
//  WorkoutViewModel.swift
//  Fitness
//
//  Created by Imen Ksouri on 03/10/2023.
//

import Foundation
import CoreLocation
import Combine

@MainActor
final class WorkoutViewModel: ObservableObject {
    private let locationManager = LocationManager()
    private let timer = TimerManager()
    private let motionManager = MotionManager()
    private let dataManager: CoreDataManager
    @Published var state: TimerMode?
    @Published var elapsedTime: TimeInterval = 0
    @Published var timerIsNil: Bool = true
    var timerIsPaused: Bool { state == .paused }
    var workoutType: WorkoutType?
    private var workoutId: UUID = UUID()
    @Published var workoutStarted: Bool = false
    @Published var startDate: Date?
    @Published var distance: Distance?
    @Published var speed: Speed?
    @Published var route: [CLLocation] = []
    var startLocation: CLLocation? { route.first }
    @Published var endLocation: CLLocation?
    @Published var steps: Step?
    @Published var calories: Calorie?
    @Published var totalElapsedTime: TimeInterval = 0
    @Published var locationAccessIsDenied: Bool = false
    @Published var locationAccessThrowsError: Bool = false
    @Published var locationAccessError = ""
    private var cancellables: Set<AnyCancellable> = []
    
    init(dataManager: CoreDataManager, type: WorkoutType?) {
        self.dataManager = dataManager
        self.workoutType = type
        locationManager.$locations.assign(to: &$route)
        locationManager.$endLocation.assign(to: &$endLocation)
        locationManager.$locationAccessIsDenied.assign(to: &$locationAccessIsDenied)
        locationManager.$locationAccessThrowsError.assign(to: &$locationAccessThrowsError)
        locationManager.$locationAccessError.assign(to: &$locationAccessError)
        timer.$isNil.assign(to: &$timerIsNil)
        timer.$state.assign(to: &$state)
        timer.$elapsedTime.assign(to: &$elapsedTime)
        locationManager.distancePublisher
            .sink { [weak self] distanceValue in
                if let self {
                    distance = Distance(
                        id: workoutId, workoutType: workoutType,
                        date: startDate, measure: distanceValue)
                }
            }
            .store(in: &cancellables)
        locationManager.speedPublisher
            .sink { [weak self] speedValue in
                if let self {
                    speed = Speed(
                        id: workoutId, workoutType: workoutType,
                        date: startDate, measure: speedValue)
                }
            }
            .store(in: &cancellables)
        $elapsedTime
            .sink { [weak self] elapsedTime in
                if let self, let startDate, elapsedTime > 0 {
                    if let workoutType, workoutType != .cycling {
                        motionManager.getSteps(startDate: startDate, endDate: startDate + elapsedTime)
                    }
                }
            }
            .store(in: &cancellables)
        motionManager.$steps
            .sink { [weak self] stepValue in
                if let self {
                    steps = Step(
                        id: workoutId, workoutType: workoutType,
                        date: startDate, count: stepValue ?? 0)
                }
            }
            .store(in: &cancellables)
    }

    func beginWorkout() {
        startDate = Date()
        workoutStarted = true
        timer.start()
        locationManager.startLocationServices()
        locationManager.endLocation = nil
    }

    func pauseWorkout() {
        timer.pause()
    }

    func resumeWorkout() {
        timer.resume()
    }

    func endWorkout() {
        totalElapsedTime = elapsedTime
        locationManager.stopLocationServices()
        getMetrics()
        timer.stop()
    }

    func cancelWorkout() {
        locationManager.stopLocationServices()
        timer.stop()
    }

    func addWorkout() {
        let workout = Workout(
            id: workoutId,
            date: startDate,
            type: workoutType,
            route: route,
            duration: totalElapsedTime,
            distance: distance,
            speed: speed,
            distances: locationManager.distances,
            speeds: locationManager.speeds,
            altitudes: locationManager.altitudes,
            steps: steps,
            calories: calories)
        dataManager.add(workout)
        dataManager.addMetrics(to: workout)
    }

    private func getMetrics() {
        let totalDistance = locationManager.totalDistance
        distance = Distance(id: workoutId, workoutType: workoutType, date: startDate,
                            measure: Measurement.init(value: totalDistance, unit: .meters))
        let averageSpeed = totalDistance / elapsedTime
        speed = Speed(id: workoutId, workoutType: workoutType, date: startDate,
                      measure: Measurement.init(value: averageSpeed, unit: .metersPerSecond))
        // Calories approximation
        switch workoutType {
        case .running:
            calories = Calorie.init(id: workoutId, workoutType: workoutType, date: startDate,
                             count: Int(totalDistance / 1000 * 70))
        case .walking:
            calories = Calorie.init(id: workoutId, workoutType: workoutType, date: startDate,
                             count: Int(totalDistance / 1000 * 55))
        case .cycling:
            calories = Calorie.init(id: workoutId, workoutType: workoutType, date: startDate,
                             count: Int(totalDistance / 1000 * 25))
        case nil:
            break
        }
    }
}
