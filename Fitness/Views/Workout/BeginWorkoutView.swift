//
//  BeginWorkoutView.swift
//  Fitness
//
//  Created by Imen Ksouri on 02/10/2023.
//

import SwiftUI

struct BeginWorkoutView: View {
    @State private var isRecordingWorkout = false
    @State private var selectedWorkout: WorkoutType?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(WorkoutType.allCases, id: \.self) { workout in
                        WorkoutCardView(workout: workout) {
                                selectedWorkout = workout
                            }
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    isRecordingWorkout.toggle()
                                }
                        )
                    }
                }
            }
            .padding(.top)
            .navigationTitle("Begin Workout")
            .fullScreenCover(isPresented: $isRecordingWorkout) {
                RecordWorkoutView(
                    workout: $selectedWorkout)
            }
        }
    }
}

#Preview {
    BeginWorkoutView()
}

enum WorkoutType: String, CaseIterable {
    case running
    case walking
    case cycling

    var icon: String {
        switch self {
        case .running: return "figure.run"
        case .walking: return "figure.walk"
        case .cycling: return "bicycle"
        }
    }
    var banner: String {
        switch self {
        case .running: return "runningBanner"
        case .walking: return "walkingBanner"
        case .cycling: return "cyclingBanner"
        }
    }
    var background: String {
        switch self {
        case .running: return "runningBackground"
        case .walking: return "walkingBackground"
        case .cycling: return "cyclingBackground"
        }
    }
}
