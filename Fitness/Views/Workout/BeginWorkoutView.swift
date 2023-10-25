//
//  BeginWorkoutView.swift
//  Fitness
//
//  Created by Imen Ksouri on 02/10/2023.
//

import SwiftUI

struct BeginWorkoutView: View {
    @State private var isRecordingWorkout = false
    @State private var selectedWorkoutType: WorkoutType?
    let dataManager: CoreDataManager

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(WorkoutType.allCases, id: \.self) { workoutType in
                        WorkoutCardView(workoutType: workoutType) {
                            selectedWorkoutType = workoutType
                            }
                        .fullScreenCover(isPresented: .constant(selectedWorkoutType == workoutType)) {
                            RecordWorkoutView(
                                dataManager: dataManager,
                                workoutType: $selectedWorkoutType)
                        }
                    }
                }
            }
            .padding(.top)
            .navigationTitle("Begin Workout")
        }
    }
}

#Preview {
    BeginWorkoutView(dataManager: .preview)
}
