//
//  TabBarView.swift
//  Fitness
//
//  Created by Imen Ksouri on 02/10/2023.
//

import SwiftUI

struct TabBarView: View {
    var dataManager: CoreDataManager

    var body: some View {
        TabView {
            BeginWorkoutView(dataManager: dataManager)
                .tabItem {
                    Label(Tab.workout.tabName, systemImage: Tab.workout.rawValue)
                }
            WorkoutHistoryView(dataManager: dataManager)
                .tabItem {
                    Label(Tab.history.tabName, systemImage: Tab.history.rawValue)
                }
            GlobalStatisticsView(dataManager: dataManager)
                .tabItem {
                    Label(Tab.statistics.tabName, systemImage: Tab.statistics.rawValue)
                }
            GoalsView()
                .tabItem {
                    Label(Tab.goals.tabName, systemImage: Tab.goals.rawValue)
                }
        }
    }
    enum Tab: String {
        case workout = "figure.run"
        case history = "clock.arrow.circlepath"
        case statistics = "chart.xyaxis.line"
        case goals = "target"

        var tabName: String {
            switch self {
            case .workout: return "Workout"
            case .history: return "History"
            case .statistics: return "Statistics"
            case .goals: return "Goals"
            }
        }
    }
}

#Preview {
    TabBarView(dataManager: .preview)
}
