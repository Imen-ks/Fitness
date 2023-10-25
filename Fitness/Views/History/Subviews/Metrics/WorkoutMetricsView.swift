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
                    + Text(" \(workout?.distance?.type.unitOfMeasure ?? "")")
                }
            } label: {
                Image(systemName: workout?.distance?.type.icon ?? "")
                    .padding(.horizontal, 1)
                    .foregroundStyle(Color.accentColor)
            }
            if allMetrics {
                LabeledContent {
                    HStack {
                        Text("Average Speed")
                        Spacer()
                        Text(speedFormatter(for: workout?.speed?.measure) ?? "")
                        + Text(" \(workout?.speed?.type.unitOfMeasure ?? "")")
                    }
                } label: {
                    Image(systemName: workout?.speed?.type.icon ?? "")
                        .padding(.horizontal, 5)
                        .foregroundStyle(Color.accentColor)
                }
                if workout?.type != .cycling {
                    LabeledContent {
                        HStack {
                            Text("Steps")
                            Spacer()
                            Text(numberFormatterInteger.string(for: workout?.steps?.count ?? 0) ?? "")
                        }
                    } label: {
                        Image(systemName: workout?.steps?.type.icon ?? "")
                            .padding(.horizontal, 5)
                            .foregroundStyle(Color.accentColor)
                    }
                }
                LabeledContent {
                    HStack {
                        Text("Calories")
                        Spacer()
                        Text(numberFormatterInteger.string(for : workout?.calories?.count ?? 0) ?? "")
                        + Text(" \(workout?.calories?.type.unitOfMeasure ?? "")")
                    }
                } label: {
                    Image(systemName: workout?.calories?.type.icon ?? "")
                        .padding(.horizontal, 5)
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
        .font(.subheadline)
    }
    private let numberFormatterInteger: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter
    }()

    private let numberFormatterDecimal: NumberFormatter = {
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
        return numberFormatterDecimal.string(for: distanceInMeters.converted(to: UnitLength.kilometers).value)
    }

    private func speedFormatter(for measure: Measurement<UnitSpeed>?) -> String? {
        guard let speedInMetersPerSecond = measure else { return nil }
        return numberFormatterDecimal.string(for: speedInMetersPerSecond.converted(to: .kilometersPerHour).value)
    }
}

#Preview {
    WorkoutMetricsView(
        workout: PersistenceController.getWorkoutForPreview(persistenceController: PersistenceController.previewPersistenceController),
        allMetrics: true)
        .padding(.horizontal)
}
