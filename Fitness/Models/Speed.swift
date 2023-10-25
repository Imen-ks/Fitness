//
//  Speed.swift
//  Fitness
//
//  Created by Imen Ksouri on 07/10/2023.
//

import Foundation

struct Speed {
    let workoutType: WorkoutType?
    let date: Date?
    let type: Measure = .speed
    let measure: Measurement<UnitSpeed>
}
