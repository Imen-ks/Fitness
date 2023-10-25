//
//  WorkoutCardView.swift
//  Fitness
//
//  Created by Imen Ksouri on 03/10/2023.
//

import SwiftUI

struct WorkoutCardView: View {
    let workout: WorkoutType
    let action: () -> ()

    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            ZStack(alignment: .top) {
                Image(workout.banner)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                HStack {
                    Text(workout.rawValue.uppercased())
                    Image(systemName: workout.icon)
                }
                .padding()
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .opacity(0.8)
            }
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ScrollView {
        WorkoutCardView(workout: .running) {}
    }
}
