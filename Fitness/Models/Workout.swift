//
//  Workout.swift
//  Fitness
//
//  Created by Imen Ksouri on 06/10/2023.
//

import Foundation
import CoreLocation

struct Workout: Identifiable {
    let id = UUID()
    let date: Date?
    let type: WorkoutType?
    let route: [CLLocation]?
    let duration: TimeInterval?
    let distance: Distance? // total distance
    let speed: Speed? // average speed
    let distances: [Measurement<UnitLength>]
    let speeds: [Measurement<UnitSpeed>]
    let altitudes: [Measurement<UnitLength>]
    let steps: Step?
    let calories: Calorie?
}
