//
//  WorkoutCardView.swift
//  Fitness
//
//  Created by Imen Ksouri on 03/10/2023.
//

import SwiftUI

struct WorkoutCardView: View {
    let workoutType: WorkoutType
    let action: () -> ()

    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            ZStack(alignment: .top) {
                Image(workoutType.banner)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                HStack {
                    Text(workoutType.name)
                    Image(systemName: workoutType.icon)
                }
                .padding()
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .opacity(0.8)
            }
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ScrollView {
        WorkoutCardView(workoutType: .running) {}
    }
}
