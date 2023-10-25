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
    let disabled: Bool
    let action: () -> ()
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Text(label)
                .frame(maxWidth: .infinity)
                .font(.title)
                .foregroundStyle(disabled ? .white : .black)
                .padding(.vertical, 20)
                .background(disabled ? .gray : color)
                .cornerRadius(10)
        }
        .frame(width: 150)
        .padding(.bottom)
        .disabled(disabled)
    }
}

#Preview {
    TimerButtonView(label: "Start", color: .green, disabled: false) {}
}
