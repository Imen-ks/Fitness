//
//  WorkoutRowView.swift
//  Fitness
//
//  Created by Imen Ksouri on 08/10/2023.
//

import SwiftUI

struct WorkoutRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var viewModel: WorkoutHistoryViewModel
    let workout: Workout

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(colorScheme == .dark ? .white.opacity(0.3) : .black.opacity(0.7))
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
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
                withAnimation {
                    viewModel.delete(workout)
                }
            } label: {
                Image(systemName: "trash")
            }
            .tint(.red)
        }
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
                    viewModel: WorkoutHistoryViewModel(dataManager: .preview),
                    workout: PersistenceController.getWorkoutForPreview(persistenceController: PersistenceController.previewPersistenceController))
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .padding()
    }
}
