//
//  Step.swift
//  Fitness
//
//  Created by Imen Ksouri on 13/10/2023.
//

import Foundation

struct Step {
    let workoutType: WorkoutType?
    let date: Date?
    let type: Measure = .step
    let count: Int
}
