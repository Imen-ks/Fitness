//
//  RecordWorkoutView.swift
//  Fitness
//
//  Created by Imen Ksouri on 02/10/2023.
//

import SwiftUI

struct RecordWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: WorkoutViewModel
    
    init(workout: Binding<WorkoutType?>) {
        if let workout = workout.wrappedValue {
            _viewModel = .init(wrappedValue: WorkoutViewModel(type: workout))
        } else {
            _viewModel = .init(wrappedValue: WorkoutViewModel())
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(viewModel.workoutType?.background ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                VStack {
                    Image(systemName: viewModel.workoutType?.icon ?? "")
                        .font(.system(size: 60))
                        .padding(.bottom, 5)
                        .foregroundColor(.white)
                    if viewModel.workoutStarted {
                        GeometryReader { geometry in
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    ForEach(Measure.allCases, id: \.self) { measure in
                                        VStack {
                                            VStack {
                                                Text(measure.rawValue)
                                                Text("0.0")
                                                Text(measure.unitOfMeasure)
                                            }
                                            .frame(width: geometry.size.width / 4)
                                            .padding(2)
                                            .background(.white.opacity(0.7))
                                            .cornerRadius(10)
                                        }
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                        }
                        .frame(height: 100)
                        .background(.black.opacity(0.7))
                        Group {
                            if #available(iOS 17.0, *) {
                                MapViewSwiftUI(
                                    locationManager: viewModel.locationManager)
                            } else {
                                MapViewUIKit(
                                    locationManager: viewModel.locationManager)
                            }
                        }
                        .cornerRadius(10)
                        .padding()
                        .opacity(0.7)
                    }
                    Spacer()
                    TimerView(timer: viewModel.timer) {
                        viewModel.beginWorkout()
                    } stopAction: {
                        viewModel.endWorkout()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black.opacity(0.7))
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                        viewModel.endWorkout()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    @State var workout: WorkoutType? = .running
    return RecordWorkoutView(workout: $workout)
}
