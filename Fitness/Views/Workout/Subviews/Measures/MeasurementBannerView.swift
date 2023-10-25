//
//  MeasurementBannerView.swift
//  Fitness
//
//  Created by Imen Ksouri on 06/10/2023.
//

import SwiftUI

struct MeasurementBannerView: View {
    let distance: Distance?
    let speed: Speed?
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.width / 2.5
            VStack {
                HStack {
                    Spacer()
                    MeasureCardView(measure: distance?.type,
                                    value: distance?.measure.value,
                                    size: size)
                    Spacer()
                    MeasureCardView(measure: speed?.type,
                                    value: speed?.measure.value,
                                    size: size)
                    Spacer()
                }
            }
        }
        .padding(.vertical)
        .frame(height: 100)
        .background(.black.opacity(0.7))
    }
}

#Preview {
    MeasurementBannerView(
        distance: .init(id: UUID(), workoutType: nil, date: nil,
                        measure: .init(value: 0, unit: .meters)),
        speed: .init(id: UUID(), workoutType: nil, date: nil,
                     measure: .init(value: 0, unit: .metersPerSecond)))
}
