//
//  TimerView.swift
//  Fitness
//
//  Created by Imen Ksouri on 01/10/2023.
//

import SwiftUI

struct TimerView: View {
    @Binding var errorIsThrown: Bool
    @Binding var accessIsDenied: Bool
    let elapsedTime: TimeInterval
    let timerIsNil: Bool
    let timerIsPaused: Bool
    let startAction: () -> ()
    let pauseAction: () -> ()
    let resumeAction: () -> ()
    let stopAction: () -> ()

    var body: some View {
        VStack {
            if errorIsThrown || accessIsDenied {
                Text("Location Access Error")
                    .font(.title)
                    .foregroundStyle(Color.accentColor)
            } else {
                Text(formatTimeIntervalToString(elapsedTime))
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
            HStack(spacing: 10) {
                if timerIsNil {
                    TimerButtonView(label: "Start", color: .green, disabled: errorIsThrown || accessIsDenied) {
                        startAction()
                    }
                } else {
                    if errorIsThrown || accessIsDenied {
                        TimerButtonView(label: "Start", color: .green, disabled: true) {}
                    } else {
                        if timerIsPaused {
                            TimerButtonView(label: "Resume", color: .green, disabled: false) {
                                resumeAction()
                            }
                        } else {
                            TimerButtonView(label: "Pause", color: .yellow, disabled: false) {
                                pauseAction()
                            }
                        }
                        TimerButtonView(label: "Stop", color: .red, disabled: false) {
                            stopAction()
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.black.opacity(0.7))
    }
    private func formatTimeIntervalToString(_ elapsedTime: TimeInterval) -> String {
        Duration(
            secondsComponent: Int64(elapsedTime),
            attosecondsComponent: 0
        ).formatted(.time(pattern: .hourMinuteSecond(padHourToLength: 2)))
    }
}

#Preview {
    TimerView(errorIsThrown: .constant(false),
              accessIsDenied: .constant(false),
              elapsedTime: 5130,
              timerIsNil: false,
              timerIsPaused: false) {} pauseAction: {} resumeAction: {} stopAction: {}
}
