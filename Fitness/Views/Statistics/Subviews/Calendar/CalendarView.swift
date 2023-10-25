//
//  CalendarView.swift
//  Fitness
//
//  Created by Imen Ksouri on 13/10/2023.
//

import SwiftUI

struct CalendarView: View {
    let selectedDate: Date
    let weeks: [[Date]]
    @State private var activeTab: Int = 1
    @State private var direction: TimeDirection = .none
    @State private var position = CGSize.zero
    let action: (Date) -> ()
    let update: (TimeDirection) -> ()

    var body: some View {
        TabView(selection: $activeTab) {
            WeekView(selectedDate: selectedDate,
                     currentWeek: weeks[0]) { day in
                action(day)
            }
            .frame(maxWidth: .infinity)
            .tag(0)

            WeekView(selectedDate: selectedDate,
                     currentWeek: weeks[1]) { day in
                action(day)
            }
            .frame(maxWidth: .infinity)
            .tag(1)
            .onDisappear() {
                guard direction != .none else { return }
                update(direction)
                direction = .none
                activeTab = 1
            }

            WeekView(selectedDate: selectedDate,
                     currentWeek: weeks[02]) { day in
                action(day)
            }
            .frame(maxWidth: .infinity)
            .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: activeTab) { value in
            if value == 0 {
                direction = .past
            } else if value == 2 {
                direction = .future
            }
        }
    }
}

#Preview {
    let calendarManager = CalendarManager()
    return CalendarView(
        selectedDate: calendarManager.selectedDate,
        weeks: calendarManager.weeks) { day in } update: { direction in }
}
