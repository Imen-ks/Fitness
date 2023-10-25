//
//  MeasureCardView.swift
//  Fitness
//
//  Created by Imen Ksouri on 07/10/2023.
//

import SwiftUI

struct MeasureCardView: View {
    let measure: Measure?
    let value: Double?
    let size: CGFloat?

    var body: some View {
        VStack {
            Text(measure?.name ?? "")
            switch measure {
            case .distance:
                Text(distanceFormatter(for: value) ?? "")
            case .speed:
                Text(speedFormatter(for: value) ?? "")
            default:
                EmptyView()
            }
            Text(measure?.unitOfMeasure ?? "")
        }
        .font(.headline)
        .frame(width: size)
        .padding(2)
        .background(.white.opacity(0.6))
        .cornerRadius(10)
    }
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        return formatter
    }()

    private func distanceFormatter(for value: Double?) -> String? {
        // conversion meters -> kilometers
        guard let valueInMeters = value else { return nil }
        return formatter.string(for: (valueInMeters / 1000))
    }

    private func speedFormatter(for value: Double?) -> String? {
        // conversion meters/second -> kilometers/hour
        guard let valueInMetersPerSecond = value else { return nil }
        return formatter.string(for: (valueInMetersPerSecond * 3.6))
    }
}

#Preview {
    GeometryReader { geometry in
        let size = geometry.size.width / 2.5
        VStack {
            HStack {
                Spacer()
                MeasureCardView(measure: .distance, value: 1000,
                                size: size)
                Spacer()
                MeasureCardView(measure: .speed, value: 2.78,
                                size: size)
                Spacer()
            }
        }
    }
    .padding(.vertical)
    .frame(height: 100)
    .background(.black.opacity(0.7))
}
