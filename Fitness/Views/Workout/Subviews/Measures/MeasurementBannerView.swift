//
//  MeasurementBannerView.swift
//  Fitness
//
//  Created by Imen Ksouri on 06/10/2023.
//

import SwiftUI

struct MeasurementBannerView: View {
    let measure: Measure
    var body: some View {
        VStack {
            VStack {
                Text(measure.rawValue)
                Text("0.0")
                Text(measure.unitOfMeasure)
            }
            .padding(2)
            .background(.white.opacity(0.7))
            .cornerRadius(10)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        VStack {
            Spacer()
            HStack {
                Spacer()
                MeasurementBannerView(measure: .distance)
                Spacer()
            }
            Spacer()
        }
    }
    .frame(height: 100)
    .background(.black.opacity(0.7))
}

enum Measure: String, CaseIterable {
    case distance = "Distance"
    case speed = "Speed"
    case altitude = "Altitude"
    
    var unitOfMeasure: String {
        switch self {
        case .distance: return "km"
        case .speed: return "km/h"
        case .altitude: return "m"
        }
    }
}
