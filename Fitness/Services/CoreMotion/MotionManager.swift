//
//  MotionManager.swift
//  Fitness
//
//  Created by Imen Ksouri on 11/10/2023.
//

import Foundation
import CoreMotion

@MainActor
final class MotionManager: ObservableObject {
    private let pedometer: CMPedometer
    var isPedometerAvailable: Bool {
        CMPedometer.isStepCountingAvailable()
    }
    @Published var steps: Int?
    @Published var error: String = ""

    init() {
        self.pedometer = CMPedometer()
    }

    func getSteps(startDate: Date, endDate: Date) {
        if isPedometerAvailable {
            self.pedometer.queryPedometerData(from: startDate, to: endDate) { [weak self] data, error in
                if let data = data {
                    DispatchQueue.main.schedule {
                        self?.steps = data.numberOfSteps.intValue
                    }
                } else if let error = error {
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
