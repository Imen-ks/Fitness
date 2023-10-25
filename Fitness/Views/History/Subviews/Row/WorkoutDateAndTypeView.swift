//
//  WorkoutDateAndTypeView.swift
//  Fitness
//
//  Created by Imen Ksouri on 09/10/2023.
//

import SwiftUI

struct WorkoutDateAndTypeView: View {
    let workout: Workout?

    var body: some View {
        HStack {
            Text(workout?.date?.formatted(date: .abbreviated, time: .omitted).uppercased() ?? "")
            Spacer()
            Text(workout?.date?.formatted(date: .omitted, time: .shortened) ?? "")
        }
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(Color.accentColor)
        HStack {
            Text(workout?.type?.name ?? "")
                .padding(5)
                .font(.caption)
                .foregroundStyle(.white)
                .background(Color.accentColor.opacity(0.7))
                .cornerRadius(8)
            Spacer()
        }
    }
}

#Preview {
    WorkoutDateAndTypeView(
        workout: PersistenceController.getWorkoutForPreview(persistenceController: PersistenceController.previewPersistenceController))
        .padding(.horizontal)
}
