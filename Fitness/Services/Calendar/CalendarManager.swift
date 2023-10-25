//
//  CalendarManager.swift
//  Fitness
//
//  Created by Imen Ksouri on 15/10/2023.
//

import Foundation

final class CalendarManager: ObservableObject {
    private let calendar = Calendar.current
    @Published var weeks: [[Date]] = []
    @Published var selectedDate = Date()

    init() {
        updateWeeks(with: selectedDate)
    }

    func update(to direction: TimeDirection) {
        selectedDate = updateWeekday(for: direction)
        updateWeeks(with: selectedDate)
    }

    private func updateWeeks(with date: Date) {
        weeks = [
            fetchWeek(for: calendar.date(byAdding: .day, value: -7, to: date)!),
            fetchWeek(for: date),
            fetchWeek(for: calendar.date(byAdding: .day, value: 7, to: date)!)
        ]
    }

    private func fetchWeek(for date: Date) -> [Date] {
        var result: [Date] = []
        let week = calendar.dateInterval(of: .weekOfMonth, for: date)
        guard let firstWeekday = week?.start else { return [] }

        (0...6).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekday) {
                result.append(weekday)
            }
        }
        return result
    }

    private func updateWeekday(for direction: TimeDirection) -> Date {
        switch direction {
        case .future :
            let date = calendar.date(byAdding: .day, value: 7, to: selectedDate)!
            let week = calendar.dateInterval(of: .weekOfMonth, for: date)!
            return week.start
        case .past :
            let date = calendar.date(byAdding: .day, value: -7, to: selectedDate)!
            let week = calendar.dateInterval(of: .weekOfMonth, for: date)!
            return week.start
        case .none :
            return selectedDate
        }
    }
}

enum TimeDirection {
    case future
    case past
    case none
}
