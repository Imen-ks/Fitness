//
//  PeriodChartView.swift
//  Fitness
//
//  Created by Imen Ksouri on 18/10/2023.
//

import SwiftUI
import Charts

struct PeriodChartView: View {
    let metric: [Metric]
    var data: [ChartData] {
        getChartData()
    }

    var body: some View {
        Chart(data) { element in
            BarMark(
                x: .value("Date", element.date, unit: .day),
                y: .value(element.measure.rawValue, element.metric)
            )
//            BarMark(
//                xStart: .value("Date", Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!, unit: .day),
//                xEnd: .value("Date", Date.now),
//                y: .value(element.measure.rawValue, element.metric)
//            )
        }
        .chartXScale(domain: Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!...Date.now)
        .aspectRatio(1, contentMode: .fit)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { date in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.narrow), centered: true)
            }
        }
//        .chartPlotStyle { plotArea in
            //
//        }
    }

    private func getChartData() -> [ChartData] {
        var data: [ChartData] = []
        for index in 0..<metric.count {
            let date = metric[index].date
            let type = metric[index].type
            let value = metric[index].value
            data.append(
                ChartData.init(
                    measure: type,
                    date: date ?? Date(),
                    metric: value
                )
            )
        }
        return data
    }

    struct ChartData: Identifiable {
        let id = UUID()
        let measure: Measure
        let date: Date
        let metric: Double
    }
}

#Preview {
    let viewModel = GlobalStatisticsViewModel()
    return PeriodChartView(metric: viewModel.distances)
}

enum Period: String, CaseIterable {
    case week
    case month
    case year
}

enum StrideBy: Identifiable, CaseIterable {
    case day
    case weekday
    case weekOfYear
    case month
    case year
    
    var id: String { title }
    
    var title: String {
        switch self {
        case .day:
            return "Day"
        case .weekday:
            return "Weekday"
        case .weekOfYear:
            return "Week of Year"
        case .month:
            return "Month"
        case .year:
            return "Year"
        }
    }
    
    var time: Calendar.Component {
        switch self {
        case .day:
            return .day
        case .weekday:
            return .weekday
        case .weekOfYear:
            return .weekOfYear
        case .month:
            return .month
        case .year:
            return .year
        }
    }
}
