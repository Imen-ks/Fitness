//
//  RecordWorkoutView.swift
//  Fitness
//
//  Created by Imen Ksouri on 02/10/2023.
//

import SwiftUI

struct RecordWorkoutView: View {
    @StateObject var viewModel: WorkoutViewModel
    @Binding var workoutType: WorkoutType?
    @State private var showAlert = false
    @State private var timerIsStopped = false
    @State private var finishedWorkout = false
    let dataManager: CoreDataManager

    init(dataManager: CoreDataManager, workoutType: Binding<WorkoutType?>) {
        self.dataManager = dataManager
        self._workoutType = workoutType
        _viewModel = .init(wrappedValue: WorkoutViewModel(dataManager: dataManager, type: workoutType.wrappedValue))
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                WorkoutBackgroundImageView(background: viewModel.workoutType?.background)
                VStack {
                    WorkoutIconView(icon: viewModel.workoutType?.icon)
                    if !viewModel.locationAccessIsDenied && !viewModel.locationAccessThrowsError {
                        if viewModel.workoutStarted {
                            MeasurementBannerView(
                                distance: viewModel.distance,
                                speed: viewModel.speed)
                            Group {
                                MapView(mapType: .moving,
                                        startLocation: viewModel.startLocation,
                                        route: viewModel.route,
                                        endLocation: viewModel.endLocation)
                            }
                        }
                    }
                    if viewModel.locationAccessIsDenied {
                        Spacer()
                        AccessDeniedView()
                    }
                    Spacer()
                    TimerView(
                        errorIsThrown: $viewModel.locationAccessThrowsError,
                        accessIsDenied: $viewModel.locationAccessIsDenied,
                        elapsedTime: viewModel.elapsedTime,
                        timerIsNil: viewModel.timerIsNil,
                        timerIsPaused: viewModel.timerIsPaused) {
                            if !viewModel.locationAccessIsDenied && !viewModel.locationAccessThrowsError {
                                viewModel.beginWorkout()
                            }
                        } pauseAction: {
                            viewModel.pauseWorkout()
                        } resumeAction: {
                            viewModel.resumeWorkout()
                        } stopAction: {
                            timerIsStopped = true
                            viewModel.pauseWorkout()
                        }
                        .alert("Are you sure ?", isPresented: $timerIsStopped) {
                            Button("Finish Workout") {
                                viewModel.endWorkout()
                                viewModel.addWorkout()
                                workoutType = nil
                            }
                            Button("Cancel", role: .cancel) {}
                        } message: {
                            Text("This will stop recording your current workout and save it to your history.")
                        }
                }
            }
            .onChange(of: viewModel.locationAccessError) { _ in
                showAlert = viewModel.locationAccessThrowsError
            }
            .alert("Location Access Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.locationAccessError)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.cancelWorkout()
                        workoutType = nil
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    @State var workoutType: WorkoutType? = .running
    return RecordWorkoutView(dataManager: .preview, workoutType: $workoutType)
}
