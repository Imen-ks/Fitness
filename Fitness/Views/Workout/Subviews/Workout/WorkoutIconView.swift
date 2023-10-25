//
//  WorkoutIconView.swift
//  Fitness
//
//  Created by Imen Ksouri on 07/10/2023.
//

import SwiftUI

struct WorkoutIconView: View {
    let icon: String?
    
    var body: some View {
        Image(systemName: icon ?? "")
            .font(.system(size: 60))
            .padding(.bottom, 5)
            .foregroundStyle(.white)
    }
}

#Preview {
    ZStack {
        WorkoutIconView(icon: "figure.run")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.black)
}
