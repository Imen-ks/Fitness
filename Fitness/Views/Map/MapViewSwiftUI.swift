//
//  MapViewSwiftUI.swift
//  Fitness
//
//  Created by Imen Ksouri on 03/10/2023.
//

import SwiftUI
import CoreLocation
import MapKit

@available(iOS 17.0, *)
struct MapViewSwiftUI: View {
    let mapType: MapType
    let startLocation: CLLocation?
    let route: [CLLocation]
    let endLocation: CLLocation?
    @State private var position: MapCameraPosition

    init(mapType: MapType, startLocation: CLLocation?,
         route: [CLLocation], endLocation: CLLocation?) {
        self.mapType = mapType
        self.startLocation = startLocation
        self.route = route
        self.endLocation = endLocation
        self._position = .init(
            wrappedValue: mapType == .moving ? .userLocation(fallback: .automatic) : .automatic)
    }

    var body: some View {
        Map(position: $position,
            bounds: MapCameraBounds(minimumDistance: 3000,
                                    maximumDistance: 3000)) {
            if startLocation != nil {
                Annotation("Start",
                           coordinate: startLocation?.coordinate ?? CLLocationCoordinate2D()) {
                    ZStack {
                        Image("start")
                            .resizable()
                            .background(.black)
                            .scaledToFill()
                            .clipShape(Circle())
                            .overlay { Circle().stroke(.white, lineWidth: 2) }
                    }
                    .frame(width: 25)
                }
               .annotationTitles(.hidden)
            }
            MapPolyline(coordinates: route.map{ $0.coordinate })
                .stroke(Color(UIColor.orange), lineWidth: 5)
            if endLocation != nil {
                Annotation("Finish",
                           coordinate: endLocation?.coordinate ?? CLLocationCoordinate2D()) {
                    ZStack {
                        Image("finish")
                            .resizable()
                            .background(.gray)
                            .scaledToFill()
                            .clipShape(Circle())
                            .overlay { Circle().stroke(.black, lineWidth: 2) }
                    }
                    .frame(width: 25)
                }
               .annotationTitles(.hidden)
            }
        }
        .cornerRadius(10)
        .padding(.vertical)
        .opacity(0.7)
        .onChange(of: route) {
            if mapType == .moving {
                position = .userLocation(fallback: .automatic)
            }
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        return MapViewSwiftUI(
            mapType: .moving,
            startLocation: PersistenceController.mockCoords.first,
            route: PersistenceController.mockCoords,
            endLocation: PersistenceController.mockCoords.last)
    } else {
        return EmptyView()
    }
}
