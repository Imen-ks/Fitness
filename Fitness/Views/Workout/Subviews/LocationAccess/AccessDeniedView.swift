//
//  AccessDeniedView.swift
//  Fitness
//
//  Created by Imen Ksouri on 10/10/2023.
//

import SwiftUI

struct AccessDeniedView: View {
    var body: some View {
        VStack {
            Text("Location Services Disabled")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(Color.accentColor)
                .padding(.bottom, 5)
            Text("Please go to your Settings and enable Location Services to be able to start recording a workout.")
                .font(.title2)
                .foregroundStyle(.white)
        }
        .padding(30)
        .frame(maxWidth: .infinity)
        .background(.black.opacity(0.7))
        .multilineTextAlignment(.center)
    }
}

#Preview {
    AccessDeniedView()
}
