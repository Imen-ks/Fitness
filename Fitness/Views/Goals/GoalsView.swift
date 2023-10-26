//
//  GoalsView.swift
//  Fitness
//
//  Created by Imen Ksouri on 20/10/2023.
//

import SwiftUI

extension UserDefaults {
    enum Keys: String {
        case distance
        case calories
        case steps
    }
}

struct GoalsView: View {
    @AppStorage(UserDefaults.Keys.distance.rawValue) private var distance: Double = 0
    @AppStorage(UserDefaults.Keys.calories.rawValue) private var calories: Int = 0
    @AppStorage(UserDefaults.Keys.steps.rawValue) private var steps: Int = 0


    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                GoalSetupView(
                    measureType: Measure.distance.name,
                    measureValue: getFormattedGoal(for: .distance),
                    unitOfMeasure: Measure.distance.unitOfMeasure
                ) {
                    increaseGoal(for: .distance)
                } decreaseAction: {
                    decreaseGoal(for: .distance)
                }
                GoalSetupView(
                    measureType: Measure.calorie.name ,
                    measureValue: getFormattedGoal(for: .calories),
                    unitOfMeasure: Measure.calorie.unitOfMeasure
                ) {
                    increaseGoal(for: .calories)
                } decreaseAction: {
                    decreaseGoal(for: .calories)
                }
                GoalSetupView(
                    measureType: Measure.step.name,
                    measureValue: getFormattedGoal(for: .steps),
                    unitOfMeasure: Measure.step.unitOfMeasure
                ) {
                    increaseGoal(for: .steps)
                } decreaseAction: {
                    decreaseGoal(for: .steps)
                }
            }
            .padding()
            .padding(.bottom)
            .navigationTitle("Goals")
        }
    }

    private func getFormattedGoal(for measure: UserDefaults.Keys) -> String {
        let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = measure == .distance ? 1 : 0
            formatter.minimumFractionDigits = measure == .distance ? 1 : 0
            return formatter
        }()
        
        switch measure {
        case .distance: return formatter.string(for: abs(distance)) ?? ""
        case .calories: return formatter.string(for: abs(Double(calories))) ?? ""
        case .steps: return formatter.string(for: abs(Double(steps))) ?? ""
        }
    }

    private func decreaseGoal(for measure: UserDefaults.Keys) {
        switch measure {
        case .distance:
            if UserDefaults.standard.double(forKey: measure.rawValue) <= 0 {
                break
            } else { UserDefaults.standard.setValue(distance - 0.5, forKey: measure.rawValue)
            }
        case .calories:
            if UserDefaults.standard.double(forKey: measure.rawValue) <= 0 {
                break
            } else { UserDefaults.standard.setValue(calories - 50, forKey: measure.rawValue)
            }
        case .steps: 
            if UserDefaults.standard.double(forKey: measure.rawValue) <= 0 {
                break
            } else {
                UserDefaults.standard.setValue(steps - 500, forKey: measure.rawValue)
            }
        }
    }

    private func increaseGoal(for measure: UserDefaults.Keys) {
        switch measure {
        case .distance: UserDefaults.standard.setValue(distance + 0.5, forKey: measure.rawValue)
        case .calories: UserDefaults.standard.setValue(calories + 50, forKey: measure.rawValue)
        case .steps: UserDefaults.standard.setValue(steps + 500, forKey: measure.rawValue)
        }
    }
}

#Preview {
    GoalsView()
}
