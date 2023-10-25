//
//  TabBarView.swift
//  Fitness
//
//  Created by Imen Ksouri on 02/10/2023.
//

import SwiftUI

struct TabBarView: View {
    enum Tab: String, CaseIterable {
        case workout = "figure.run"
        case history
        case statistics = "chart.xyaxis.line"
        case goals = "target"

        var tabName: String {
            switch self {
            case .workout: return "Workout"
            case .history: return "Dashboard"
            case .statistics: return "Statistics"
            case .goals: return "Goals"
            }
        }
    }
    var body: some View {
        TabView {
            TimerView()
                .tabItem {
                    Label(Tab.workout.tabName, systemImage: Tab.workout.rawValue)
                }
            Text("History")
                .tabItem {
                    Label(Tab.history.tabName, systemImage: Tab.history.rawValue)
                }
            Text("Statistics")
                .tabItem {
                    Label(Tab.statistics.tabName, systemImage: Tab.statistics.rawValue)
                }
            Text("Goals")
                .tabItem {
                    Label(Tab.goals.tabName, systemImage: Tab.goals.rawValue)
                }
        }
    }
}

#Preview {
    TabBarView()
}
