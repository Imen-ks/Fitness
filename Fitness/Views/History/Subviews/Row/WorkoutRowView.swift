//
//  WorkoutRowView.swift
//  Fitness
//
//  Created by Imen Ksouri on 08/10/2023.
//

import SwiftUI
import CoreLocation

struct WorkoutRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    let workout: Workout

    var body: some View {
        ZStack {
            HStack(spacing: 5) {
                VStack(spacing: 5) {
                    WorkoutDateAndTypeView(workout: workout)
                    WorkoutMetricsView(workout: workout,
                                       allMetrics: false)
                }
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
            .font(.title3)
            .foregroundStyle(.white)
        }
        .overlay(
                Rectangle()
                    .stroke(colorScheme == .dark ? Color.accentColor.opacity(0.3) : .white, lineWidth: 5)
                    .cornerRadius(4)
        )
        .padding(.bottom, colorScheme == .dark ? 1 : 0)
    }
}

#Preview {
    NavigationStack {
        List {
            ZStack {
                NavigationLink {
                    //
                } label: {
                    EmptyView()
                }
                WorkoutRowView(
                    workout: MockData.mockWorkout)
                .background(.black.opacity(0.7))
                .cornerRadius(4)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .padding()
    }
}
