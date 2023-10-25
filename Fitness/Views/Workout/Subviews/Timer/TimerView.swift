//
//  TimerView.swift
//  Fitness
//
//  Created by Imen Ksouri on 01/10/2023.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timer: TimerManager
    let startAction: () -> ()
    let stopAction: () -> ()

    var body: some View {
        VStack {
            Text(timer.formattedElapsedTime)
                .font(.largeTitle)
                .foregroundColor(.white)
            HStack(spacing: 10) {
                if timer.isNil {
                    TimerButtonView(label: "Start", color: .green) {
                        startAction()
                    }
                } else {
                    if timer.isPaused {
                        TimerButtonView(label: "Resume", color: .green) {
                            timer.resume()
                        }
                    } else {
                        TimerButtonView(label: "Pause", color: .yellow) {
                            timer.pause()
                        }
                    }
                    TimerButtonView(label: "Stop", color: .red) {
                        stopAction()
                    }
                }
            }
        }
    }
}

#Preview {
    TimerView(timer: TimerManager()) {} stopAction: {}
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.black)
}
