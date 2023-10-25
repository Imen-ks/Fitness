//
//  Measure.swift
//  Fitness
//
//  Created by Imen Ksouri on 07/10/2023.
//

import Foundation

enum Measure: Int16, CaseIterable {
    case distance
    case speed
    case step
    case calorie

    var name: String {
        switch self {
        case .distance: return "Distance"
        case .speed: return "Speed"
        case .step: return "Steps"
        case .calorie: return "Calories"
        }
    }
    
    var unitOfMeasure: String {
        switch self {
        case .distance: return "km"
        case .speed: return "km/h"
        case .step: return "steps"
        case .calorie: return "kcal"
        }
    }

    var icon: String {
        switch self {
        case .distance: return "road.lanes"
        case .speed: return "speedometer"
        case .step: return "shoeprints.fill"
        case .calorie: return "scalemass"
        }
    }
}
