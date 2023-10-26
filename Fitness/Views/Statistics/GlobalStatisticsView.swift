//
//  GlobalStatisticsView.swift
//  Fitness
//
//  Created by Imen Ksouri on 16/10/2023.
//

import SwiftUI

struct GlobalStatisticsView: View {
    @StateObject var viewModel: GlobalStatisticsViewModel
    @State private var selection: Period = .week
    @State private var showDailyStats = false
    let dataManager: CoreDataManager

    init(dataManager: CoreDataManager) {
        self.dataManager = dataManager
        self._viewModel = .init(wrappedValue: GlobalStatisticsViewModel(dataManager: dataManager))
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                List {
                    Picker("", selection: $selection) {
                        ForEach(Period.allCases, id: \.self) { period in
                            Text(period.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    .background(Color(UIColor.secondarySystemBackground))
                    Group {
                        VStack(alignment: .leading) {
                            ChartTitleView(title: "Distance travelled")
                            PeriodChartView(
                                selection: $selection,
                                metric: viewModel.distances)
                        }
                        VStack(alignment: .leading) {
                            ChartTitleView(title: "Calories burned")
                            PeriodChartView(
                                selection: $selection,
                                metric: viewModel.calories)
                        }
                        VStack(alignment: .leading) {
                            ChartTitleView(title: "Steps taken")
                            PeriodChartView(
                                selection: $selection,
                                metric: viewModel.steps)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .padding(.top)
                .navigationTitle("Statistics")
                .toolbar {
                    Button {
                        withAnimation {
                            showDailyStats.toggle()
                        }
                    } label: {
                        VStack {
                            Image(systemName: "calendar")
                                .font(.title2)
                            Text("Daily stats")
                                .font(.subheadline)
                                .padding(.vertical, 1)
                        }
                        .padding(.top)
                    }
                    .fullScreenCover(isPresented: $showDailyStats) {
                        NavigationStack {
                            DailyStatisticsView(showDailyStats: $showDailyStats, dataManager: dataManager)
                        }
                    }
                }
                
            }
            .onAppear { viewModel.updateView() } // to update goals
        }
    }
}

#Preview {
    GlobalStatisticsView(dataManager: .preview)
}

struct ChartTitleView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.subheadline)
    }
}
