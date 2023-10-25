//
//  ChartView.swift
//  Fitness
//
//  Created by Imen Ksouri on 09/10/2023.
//

import SwiftUI
import Charts

struct WorkoutChartView: View {
    let workout: Workout?
    let metric: Metric
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
                        RuleMark(y: workout?.type == .cycling
                                 ? .value("Average", speedFormatter(for: workout?.speed?.measure))
                                 : .value("Average", paceFormatter(for: workout?.speed?.measure))
                        )
                        .lineStyle(StrokeStyle(lineWidth: 1))
                        .annotation(position: .top, alignment: .leading) {
                            ZStack {
                                switch workout?.type {
                                case .cycling:
                                    Text("Average speed: \(formatter.string(for: speedFormatter(for: workout?.speed?.measure)) ?? "") km/h")
                                default:
                                    Text("Average pace: \(formatter.string(for: paceFormatter(for: workout?.speed?.measure)) ?? "") min/km")
                                        .padding(.horizontal, 5)
                                }
                            }
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

    private func distanceFormatter(for distance: Measurement<UnitLength>?) -> Double {
        guard let distanceInMeters = distance else { return 0 }
        return distanceInMeters.converted(to: .kilometers).value
    }

    private func speedFormatter(for speed: Measurement<UnitSpeed>?) -> Double {
        guard let speedInMetersPerSecond = speed else { return 0 }
        return speedInMetersPerSecond.converted(to: .kilometersPerHour).value
    }

    private func paceFormatter(for speed: Measurement<UnitSpeed>?) -> Double {
        guard let speedInMetersPerSecond = speed else { return 0 }
        return 1000 / 60 / speedInMetersPerSecond.value // min/km
    }

    private func getChartData() -> [ChartData] {
        var data: [ChartData] = []
        switch metric {
        case .cadence:
            for index in 0..<(workout?.distances.count ?? 0) {
                data.append(
                    ChartData.init(
                    distance: distanceFormatter(
                        for: workout?.distances[index]),
                    metric: workout?.type == .cycling
                    ? speedFormatter(for: workout?.speeds[index])
                    : paceFormatter(for: workout?.speeds[index])
                ))
            }
            return data
        case .altitude:
            for index in 0..<(workout?.distances.count ?? 0) {
                data.append(
                    ChartData.init(
                    distance: distanceFormatter(
                        for: workout?.distances[index]),
                    metric: workout?.altitudes[index].value ?? 0
                ))
            }
            return data
        }
    }
}

#Preview {
    VStack {
        WorkoutChartView(workout: MockData.mockWorkout1, metric: .cadence)
            .padding()
            .frame(height: 250)
        WorkoutChartView(workout: MockData.mockWorkout1, metric: .altitude)
            .padding()
            .frame(height: 250)
    }
}

struct ChartData: Identifiable {
    let id = UUID()
    let distance: Double
    let metric: Double
}

enum Metric {
    case cadence
    case altitude
}
