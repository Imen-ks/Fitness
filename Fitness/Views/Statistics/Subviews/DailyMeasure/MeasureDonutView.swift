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
    let formattedMeasure: String
    let unitOfMeasure: String
    let icon: String
    let goal: Double
    let height: CGFloat

    var body: some View {
        Circle()
            .strokeBorder(colorScheme == .dark ? .white.opacity(0.3) : .black.opacity(0.7), lineWidth: 40)
            .overlay {
                VStack(spacing: 5) {
                    Image(systemName: icon)
                        .font(.system(size: 50))
                    Text(formattedMeasure)
                    Text(unitOfMeasure)
                }
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(Color.accentColor)
            }
            .overlay  {
                MeasureArc(measure: measure, goal: goal)
                    .rotation(Angle(degrees: -90))
                    .stroke(Color.accentColor, lineWidth: 20)
            }
            .frame(height: height)
    }
}

#Preview {
    VStack(spacing: 5) {
        MeasureDonutView(measure: 2236,
                         formattedMeasure: "2.236",
                         unitOfMeasure: Measure.distance.unitOfMeasure,
                         icon: Measure.distance.icon,
                         goal: 2500,
                         height: .infinity)
        MeasureDonutView(measure: 326,
                         formattedMeasure: "326",
                         unitOfMeasure: Measure.calorie.unitOfMeasure,
                         icon: Measure.calorie.icon,
                         goal: 350,
                         height: .infinity)
        MeasureDonutView(measure: 10350,
                         formattedMeasure: "10 350",
                         unitOfMeasure: Measure.step.unitOfMeasure,
                         icon: Measure.step.icon,
                         goal: 10000,
                         height: .infinity)
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
