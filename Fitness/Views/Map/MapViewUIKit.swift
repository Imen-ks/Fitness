//
//  MapViewUIKit.swift
//  Fitness
//
//  Created by Imen Ksouri on 04/10/2023.
//

import SwiftUI
import MapKit

struct MapViewUIKit: View {
    let mapType: MapType
    let startLocation: CLLocation?
    let route: [CLLocation]
    let endLocation: CLLocation?
    
    var body: some View {
        MapViewUI(mapType: .moving, // !!! à mettre à jour
                startLocation: startLocation,
                endLocation: endLocation,
                route: route)
        .cornerRadius(10)
        .padding()
        .opacity(0.7)
    }
}

struct MapViewUI: UIViewRepresentable {
    enum MapType {
        case fixed
        case moving
    }
    let mapView = MKMapView()
    let regionRadius: CLLocationDistance = 2250
    let mapType: MapType?
    var startLocation: CLLocation?
    var endLocation: CLLocation?
    var route: [CLLocation]

    func makeUIView(context: UIViewRepresentableContext<MapViewUI>) -> MKMapView {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: false)
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.isRotateEnabled = true
        mapView.isZoomEnabled = false
        mapView.delegate = context.coordinator
        mapView.register(LocationAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        if let startPoint { mapView.addAnnotation(startPoint) }
        if let endPoint { mapView.addAnnotation(endPoint) }
        mapView.addOverlay(polyline)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapViewUI>) {
        let region = MKCoordinateRegion(center: uiView.userLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        uiView.setRegion(region, animated: false)
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
        if let startPoint { uiView.addAnnotation(startPoint) }
        if let endPoint { uiView.addAnnotation(endPoint) }
        uiView.addOverlay(polyline)
    }

    func makeCoordinator() -> MapCoordinator {
        .init(self)
    }
}

extension MapViewUI {
    var startPoint: MKPointAnnotation? {
        if let startLocation {
            let startAnnotation = MKPointAnnotation()
            startAnnotation.title = "Start"
            startAnnotation.coordinate = startLocation.coordinate
            return startAnnotation
        }
        return nil
    }
    var endPoint: MKPointAnnotation? {
        if let endLocation {
            let endAnnotation = MKPointAnnotation()
            endAnnotation.title = "Finish"
            endAnnotation.coordinate = endLocation.coordinate
            return endAnnotation
        }
        return nil
    }
    var polyline: MKPolyline {
        MKPolyline(
            coordinates: route.map { $0.coordinate },
            count: route.count)
    }
}

#Preview {
    MapViewUIKit(
        mapType: .moving,
        startLocation: MockData.mockCoords.first,
        route: MockData.mockCoords,
        endLocation: MockData.mockCoords.last)
}
