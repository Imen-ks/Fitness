//
//  Metric.swift
//  Fitness
//
//  Created by Imen Ksouri on 19/10/2023.
//

import Foundation

protocol Metric {
    var id: UUID { get }
    var workoutType: WorkoutType? { get }
    var date: Date? { get }
    var type: Measure { get }
    var value: Double { get }
}
