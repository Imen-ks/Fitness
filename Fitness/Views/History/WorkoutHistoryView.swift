//
//  WorkoutHistoryView.swift
//  Fitness
//
//  Created by Imen Ksouri on 08/10/2023.
//

import SwiftUI
import MapKit

struct WorkoutHistoryView: View {
    @StateObject var viewModel: WorkoutHistoryViewModel
    @State private var isSelectingWorkout = false
    @State private var selectedWorkout: Workout?
    let dataManager: CoreDataManager

    init(dataManager: CoreDataManager) {
        self.dataManager = dataManager
        self._viewModel = .init(wrappedValue: WorkoutHistoryViewModel(dataManager: dataManager))
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredWorkouts) { workout in
                    WorkoutRowView(viewModel: viewModel, workout: workout)
                        .onTapGesture {
                            selectedWorkout = workout
                        }
                        .navigationDestination(isPresented: .constant(selectedWorkout == workout)) {
                            WorkoutDetailView(workout: selectedWorkout)
                        }
                }
                .listRowInsets(.init(top: 4, leading: 0, bottom: 4, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .padding(.horizontal)
            .navigationTitle("History")
            .toolbar {
                FilterMenuView(workoutType: $viewModel.filteredType)
            }
            .onChange(of: viewModel.filteredType, perform: { _ in
                viewModel.filterWorkouts()
            })
            .onAppear {
                selectedWorkout = nil
                viewModel.filterWorkouts()
            }
        }
    }
}

#Preview {
    WorkoutHistoryView(dataManager: .preview)
}
