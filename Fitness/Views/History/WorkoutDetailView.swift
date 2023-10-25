//
//  WorkoutDetailView.swift
//  Fitness
//
//  Created by Imen Ksouri on 08/10/2023.
//

import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    WorkoutDateAndTypeView(workout: workout)
                    MapView(
                        mapType: .stationary,
                        startLocation: workout?.route?.first,
                        route: workout?.route ?? [],
                        endLocation: workout?.route?.last)
                    .frame(height: geometry.size.height / 2.5)
                    WorkoutMetricsView(workout: workout, allMetrics: true)
                    WorkoutChartView(workout: workout, metric: .cadence)
                        .frame(height: geometry.size.height / 3.5)
                    WorkoutChartView(workout: workout, metric: .altitude)
                        .frame(height: geometry.size.height / 3.5)
                        .offset(y: -30)
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    WorkoutDetailView(
        workout: PersistenceController.getWorkoutForPreview(persistenceController: PersistenceController.previewPersistenceController))
}
