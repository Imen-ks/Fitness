//
//  WorkoutChartView.swift
//  Fitness
//
//  Created by Imen Ksouri on 09/10/2023.
//

import SwiftUI
import Charts

struct WorkoutChartView: View {
    let workout: Workout?
    let metric: MetricType
    var data: [ChartData] {
        getChartData()
    }

    var body: some View {
        VStack(alignment: .leading) {
            if data.map({ $0.distance }).reduce(0, +) > 0 {
                Text(metric == .cadence
                     ? workout?.type == .cycling ? "Speed" : "Pace"
                     : "Altitude")
                    .font(.title3)
                    .foregroundStyle(Color.accentColor)
                Chart(data) { element in
                    if metric == .altitude {
                        LineMark(
                            x: .value("Distance", element.distance),
                            y: .value("Speed", element.metric))
                    }
                    if metric == .cadence {
                        AreaMark(
                            x: .value("Distance", element.distance),
                            y: .value("Speed", element.metric))
                        .opacity(0.3)
                        RuleMark(y: .value("Average", getAverage(for: workout?.type)))
                        .lineStyle(StrokeStyle(lineWidth: 1))
                        .annotation(position: .top, alignment: .leading) {
                            Text(getFormattedAverage(for: workout?.type))
                                .padding(.horizontal, 5)
                                .font(.caption)
                                .foregroundStyle(Color.accentColor)
                        }
                    }
                }
                .chartXAxis{
                    AxisMarks(values: .automatic(minimumStride: 0.2, desiredCount: 6))
                }
                .chartYAxis{
                    AxisMarks(values: .automatic(minimumStride: 2, desiredCount: 6))
                }
                .chartPlotStyle { plotArea in
                    plotArea.background(Color.accentColor.opacity(0.3))
                        .border(Color.accentColor, width: 1)
                }
            }
        }
        .padding(.vertical)
    }
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        return formatter
    }()

    private func paceFormatter(for speed: Measurement<UnitSpeed>?) -> Double {
        guard let speedInMetersPerSecond = speed else { return 0 }
        return 1000 / 60 / speedInMetersPerSecond.value // min/km
    }

    private func getChartData() -> [ChartData] {
        var data: [ChartData] = []
        switch metric {
        case .cadence:
            for index in 0..<(workout?.distances?.count ?? 0) {
                data.append(
                    ChartData.init(
                        distance: workout?.distances?[index].value ?? 0,
                    metric: workout?.type == .cycling
                        ? workout?.speeds?[index].converted(to: .kilometersPerHour).value ?? 0
                        : paceFormatter(for: workout?.speeds?[index])
                    )
                )
            }
            return data
        case .altitude:
            for index in 0..<(workout?.distances?.count ?? 0) {
                data.append(
                    ChartData.init(
                        distance: workout?.distances?[index].value ?? 0,
                        metric: workout?.altitudes?[index].value ?? 0
                    )
                )
            }
            return data
        }
    }

    struct ChartData: Identifiable {
        let id = UUID()
        let distance: Double
        let metric: Double
    }

    enum MetricType {
        case cadence
        case altitude
    }

    private func getAverage(for type: WorkoutType?) -> Double {
        switch type {
        case .cycling: return workout?.speed?.value ?? 0
        default: return paceFormatter(for: workout?.speed?.measure)
        }
    }

    private func getFormattedAverage(for type: WorkoutType?) -> String {
        switch type {
        case .cycling:
            return "Average speed: " + (formatter.string(for: workout?.speed?.value ?? 0) ?? "") + " km/h"
        default:
            return "Average pace: " + (formatter.string(for: paceFormatter(for: workout?.speed?.measure)) ?? "") + " min/km"
        }
    }
}

#Preview {
    VStack {
        WorkoutChartView(
            workout: PersistenceController.getWorkoutForPreview(persistenceController: PersistenceController.previewPersistenceController),
            metric: .cadence)
            .padding()
            .frame(height: 250)
        WorkoutChartView(
            workout: PersistenceController.getWorkoutForPreview(persistenceController: PersistenceController.previewPersistenceController),
            metric: .altitude)
            .padding()
            .frame(height: 250)
    }
}
