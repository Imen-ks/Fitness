//
//  WeekView.swift
//  Fitness
//
//  Created by Imen Ksouri on 15/10/2023.
//

import SwiftUI

struct WeekView: View {
    @Namespace var animation
    let selectedDate: Date
    let currentWeek: [Date]
    let action: (Date) -> ()
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(currentWeek, id: \.self) { day in
                VStack(spacing: 10) {
                    Text(extractDate(date: day, format: "dd"))
                    Text(extractDate(date: day, format: "EEE"))
                    Circle()
                        .fill(.white)
                        .frame(width: 8, height: 8)
                        .opacity(isSameDate(selectedDate, and: day) ? 1 : 0)
                }
                .frame(width: 45, height: 90)
                .foregroundStyle(isSameDate(selectedDate, and: day) ? Color.white : Color.secondary)
                .fontWeight(.semibold)
                .background(
                    ZStack {
                        if isSameDate(selectedDate, and: day) {
                            Capsule()
                                .fill(Color.accentColor)
                                .matchedGeometryEffect(id: "selection", in: animation)
                        }
                    }
                )
                .contentShape(Capsule())
                .onTapGesture {
                    action(day)
                }
            }
        }
        .padding(.horizontal)
    }

    private func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    private func isSameDate(_ date1: Date, and date2: Date) -> Bool {
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}

#Preview {
    var currentWeek: [Date] {
        var currentWeek = [Date]()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: Date())
        guard let firstWeekday = week?.start else { return [Date]() }
        (0...6).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekday) {
                currentWeek.append(weekday)
            }
        }
        return currentWeek
    }
    return WeekView(selectedDate: Date(), currentWeek: currentWeek) { _ in}
}
