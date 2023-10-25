//
//  DailyStatisticsView.swift
//  Fitness
//
//  Created by Imen Ksouri on 16/10/2023.
//

import SwiftUI

struct DailyStatisticsView: View {
    @StateObject var viewModel: DailyStatisticsViewModel
    @Binding var showDailyStats: Bool
    let dataManager: CoreDataManager

    init(showDailyStats: Binding<Bool>, dataManager: CoreDataManager) {
        self._showDailyStats = showDailyStats
        self.dataManager = dataManager
        self._viewModel = .init(wrappedValue: DailyStatisticsViewModel(dataManager: dataManager))
    }

    var body: some View {
        GeometryReader { geo in
            VStack {
                CalendarView(selectedDate: viewModel.selectedDate,
                             weeks: viewModel.weeks) { day in
                    viewModel.selectedDate = day
                } update: { direction in
                    viewModel.update(to: direction)
                }
                .frame(height: 90)
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(0..<viewModel.measures.count, id: \.self) { index in
                            let date = viewModel.measures[index].date
                            let measure = viewModel.measures[index].type
                            let value = viewModel.measures[index].value
                            if isSameDate(viewModel.selectedDate, and: date) {
                                MeasureDonutView(
                                    measure: value,
                                    formattedMeasure: formattedMeasure(measure: measure, value: value),
                                    unitOfMeasure: measure.unitOfMeasure,
                                    icon: measure.icon,
                                    goal: viewModel.getGoal(for: measure),
                                    height: geo.size.height / 2)
                            }
                        }
                    }
                }
            }
            .onChange(of: viewModel.selectedDate) { _ in
                viewModel.fetchMeasures()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        showDailyStats.toggle()
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .padding(.bottom)
                }
            }
        }
    }
    private func isSameDate(_ date1: Date, and date2: Date) -> Bool {
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }

    private func formattedMeasure(measure: Measure, value: Double) -> String {
        let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = measure == .distance ? 1 : 0
            formatter.minimumFractionDigits = measure == .distance ? 1 : 0
            return formatter
        }()
        return formatter.string(for: value) ?? ""
    }
}

#Preview {
    NavigationStack {
        DailyStatisticsView(showDailyStats: .constant(false), dataManager: .preview)
    }
}
