//
//  MeasureDonutView.swift
//  Fitness
//
//  Created by Imen Ksouri on 16/10/2023.
//

import SwiftUI

struct MeasureDonutView: View {
    @Environment(\.colorScheme) private var colorScheme
    let measure: Double
    let unitOfMeasure: String
    let icon: String
    let goal: Double

    var body: some View {
        Circle()
            .strokeBorder(colorScheme == .dark ? .white.opacity(0.3) : .black.opacity(0.7), lineWidth: 40)
            .overlay {
                VStack(spacing: 3) {
                    Image(systemName: icon)
                    Text(String(measure))
                    Text(String(unitOfMeasure))
                }
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(Color.accentColor)
            }
            .overlay  {
                MeasureArc(measure: measure, goal: goal)
                    .rotation(Angle(degrees: -90))
                    .stroke(Color.accentColor, lineWidth: 20)
            }
            .padding(.horizontal)
    }
}

#Preview {
    let distance: Distance = .init(workoutType: .running, date: Date(), measure: .init(value: 2236, unit: .meters))
    let calories: Calorie = .init(workoutType: .running, date: Date(), count: 326)
    let steps: Step = .init(workoutType: .running, date: Date(), count: 10350)
    return VStack(spacing: 10) {
        MeasureDonutView(measure: distance.measure.value / 1000,
                                unitOfMeasure: distance.type.unitOfMeasure,
                                icon: distance.type.icon,
                                goal: 2500 / 1000)
        MeasureDonutView(measure: Double(calories.count),
                                unitOfMeasure: calories.type.unitOfMeasure,
                                icon: calories.type.icon,
                                goal: 350)
        MeasureDonutView(measure: Double(steps.count),
                                unitOfMeasure: steps.type.unitOfMeasure,
                                icon: steps.type.icon,
                                goal: 10000)
    }
}

struct MeasureArc: Shape {
    let measure: Double
    let goal: Double

    private var degreesPerUnit: Double {
        360.0 / goal
    }
    private var startAngle: Angle {
        Angle(degrees: 0)
    }
    private var endAngle: Angle {
        Angle(degrees: startAngle.degrees + degreesPerUnit * measure)
    }
        
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 40
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
