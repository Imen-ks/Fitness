//
//  MapView.swift
//  Fitness
//
//  Created by Imen Ksouri on 08/10/2023.
//

import SwiftUI
import CoreLocation

struct MapView: View {
    let mapType: MapType
    let startLocation: CLLocation?
    let route: [CLLocation]
    let endLocation: CLLocation?
    
    var body: some View {
        if #available(iOS 17.0, *) {
            MapViewSwiftUI(
                mapType: mapType,
                startLocation: startLocation,
                route: route,
                endLocation: endLocation)
        } else {
            MapViewUIKit(
                mapType: mapType,
                startLocation: startLocation,
                route: route,
                endLocation: endLocation)
        }
    }
}

#Preview {
    MapView(mapType: .moving,
            startLocation: PersistenceController.mockCoords.first,
            route: PersistenceController.mockCoords,
            endLocation: PersistenceController.mockCoords.last)
}

enum MapType {
    case stationary
    case moving
}
