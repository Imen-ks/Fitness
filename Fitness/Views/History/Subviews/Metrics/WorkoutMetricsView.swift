//
//  WorkoutMetricsView.swift
//  Fitness
//
//  Created by Imen Ksouri on 09/10/2023.
//

import SwiftUI

struct WorkoutMetricsView: View {
    let workout: Workout?
    let allMetrics: Bool

    var body: some View {
        VStack {
            LabeledContent {
                HStack {
                    Text("Duration")
                    Spacer()
                    Text(durationFormatter(for: workout?.duration) ?? "")
                }
            } label: {
                Image(systemName: "timer")
                    .padding(.horizontal, 5)
                    .foregroundStyle(Color.accentColor)
            }
            LabeledContent {
                HStack {
                    Text("Distance")
                    Spacer()
                    Text(distanceFormatter(for: workout?.distance?.measure) ?? "")
                    + Text(" km")
                }
            } label: {
                Image(systemName: "road.lanes")
                    .foregroundStyle(Color.accentColor)
            }
            if allMetrics {
                LabeledContent {
                    HStack {
                        Text("Average Speed")
                        Spacer()
                        Text(speedFormatter(for: workout?.speed?.measure) ?? "")
                        + Text(" km/h")
                    }
                } label: {
                    Image(systemName: "speedometer")
                        .padding(.horizontal, 5)
                        .foregroundStyle(Color.accentColor)
                }
                LabeledContent {
                    HStack {
                        Text("Steps")
                        Spacer()
                        Text(String(workout?.steps ?? 0))
                    }
                } label: {
                    Image(systemName: "shoeprints.fill")
                        .padding(.horizontal, 5)
                        .foregroundStyle(Color.accentColor)
                }
                LabeledContent {
                    HStack {
                        Text("Calories")
                        Spacer()
                        Text(String(workout?.calories ?? 0))
                        + Text(" kcal")
                    }
                } label: {
                    Image(systemName: "scalemass")
                        .padding(.horizontal, 5)
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
        .font(.subheadline)
    }
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        return formatter
    }()

    private func durationFormatter(for duration: TimeInterval?) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: duration ?? 0)
    }

    private func distanceFormatter(for measure: Measurement<UnitLength>?) -> String? {
        guard let distanceInMeters = measure else { return nil }
        return numberFormatter.string(for: distanceInMeters.converted(to: UnitLength.kilometers).value)
    }

    private func speedFormatter(for measure: Measurement<UnitSpeed>?) -> String? {
        guard let speedInMetersPerSecond = measure else { return nil }
        return numberFormatter.string(for: speedInMetersPerSecond.converted(to: .kilometersPerHour).value)
    }
}

#Preview {
    WorkoutMetricsView(workout: MockData.mockWorkout, allMetrics: true)
        .padding(.horizontal)
}
