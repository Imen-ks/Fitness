//
//  TimerManager.swift
//  Fitness
//
//  Created by Imen Ksouri on 01/10/2023.
//

import Foundation

@MainActor
final class TimerManager: ObservableObject {
    var timer: Timer.TimerPublisher?
    @Published var state: TimerMode?
    @Published var elapsedTime: TimeInterval = 0
    @Published var isNil: Bool = true

    private func setTimer(from date: Date) {
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
        timer?
            .autoconnect()
            .map { $0.timeIntervalSince(date)}
            .assign(to: &$elapsedTime)
    }

    func start() {
        state = .counting
        isNil = false
        setTimer(from: Date())
    }

    func pause() {
        state = .paused
        isNil = false
        timer?.connect().cancel()
    }

    func resume() {
        state = .resuming
        isNil = false
        setTimer(from: Date() - elapsedTime)
    }

    func stop() {
        timer?.connect().cancel()
        isNil = true
        elapsedTime = 0
    }
}

enum TimerMode {
    case counting
    case paused
    case resuming
}
