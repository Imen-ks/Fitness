//
//  WorkoutBackgroundImageView.swift
//  Fitness
//
//  Created by Imen Ksouri on 07/10/2023.
//

import SwiftUI

struct WorkoutBackgroundImageView: View {
    let background: String?
    
    var body: some View {
        Image(background ?? "")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
}

#Preview {
    WorkoutBackgroundImageView(background: WorkoutType.running.background)
}
