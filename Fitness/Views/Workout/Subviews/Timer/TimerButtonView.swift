//
//  TimerButtonView.swift
//  Fitness
//
//  Created by Imen Ksouri on 02/10/2023.
//

import SwiftUI

struct TimerButtonView: View {
    let label: String
    let color: Color
    let action: () -> ()
    var body: some View {
        Button(action: action, label: {
            Text(label)
                .frame(maxWidth: .infinity)
                .font(.title)
                .foregroundColor(.black)
                .padding(.vertical, 20)
                .background(color)
                .cornerRadius(10)
        })
        .frame(width: 150)
        .padding(.bottom)
    }
}

#Preview {
    TimerButtonView(label: "Start", color: .green) {}
}
