//
//  IncreaseGoalButtonView.swift
//  Fitness
//
//  Created by Imen Ksouri on 20/10/2023.
//

import SwiftUI

struct IncreaseGoalButtonView: View {
    let action: () -> Void

    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Image(systemName: "plus")
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 25, height: 25)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(10)
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    IncreaseGoalButtonView() {}
}
