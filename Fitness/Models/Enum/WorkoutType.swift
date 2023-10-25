//
//  WorkoutType.swift
//  Fitness
//
//  Created by Imen Ksouri on 02/10/2023.
//

import Foundation

enum WorkoutType: Int16, CaseIterable {
    case running
    case walking
    case cycling

    var name: String {
        switch self {
        case .running: return "Running"
        case .walking: return "Walking"
        case .cycling: return "Cycling"
        }
    }

    var icon: String {
        switch self {
        case .running: return "figure.run"
        case .walking: return "figure.walk"
        case .cycling: return "figure.outdoor.cycle"
        }
    }
    var banner: String {
        switch self {
        case .running: return "runningBanner"
        case .walking: return "walkingBanner"
        case .cycling: return "cyclingBanner"
        }
    }
    var background: String {
        switch self {
        case .running: return "runningBackground"
        case .walking: return "walkingBackground"
        case .cycling: return "cyclingBackground"
        }
    }
}
