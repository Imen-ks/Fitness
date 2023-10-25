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
            Text(dateFormatter.string(for: workout?.date)?.uppercased() ?? "")
            Spacer()
            Text(timeFormatter.string(for: workout?.date) ?? "")
        }
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(Color.accentColor)
        HStack {
            Text(workout?.type?.rawValue.uppercased() ?? "")
                .padding(5)
                .font(.caption)
                .foregroundStyle(.white)
                .background(Color.accentColor.opacity(0.7))
                .cornerRadius(8)
            Spacer()
        }
    }
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}

#Preview {
    WorkoutDateAndTypeView(workout: MockData.mockWorkout)
        .padding(.horizontal)
}
