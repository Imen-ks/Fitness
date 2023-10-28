//
//  LocationManager.swift
//  Fitness
//
//  Created by Imen Ksouri on 03/10/2023.
//

import Foundation
import CoreLocation
import Combine

@MainActor
final class LocationManager: NSObject, ObservableObject {
    private let locationManager: CLLocationManager
    private var isRecording = false
    var previousLocation: CLLocation?
    @Published var locationAccessIsDenied: Bool = false
    @Published var locationAccessThrowsError: Bool = false
    @Published var locationAccessError = ""
    @Published var locations: [CLLocation] = []
    @Published var distances: [Measurement<UnitLength>] = []
    @Published var speeds: [Measurement<UnitSpeed>] = []
    @Published var altitudes: [Measurement<UnitLength>] = []
    var startLocation: CLLocation? { locations.first }
    @Published var endLocation: CLLocation?
    @Published var totalDistance: CLLocationDistance = 0
    var distancePublisher: AnyPublisher<Measurement<UnitLength>, Never> {
        $distances.flatMap { distances in distances.publisher }.eraseToAnyPublisher()
    }
    var speedPublisher: AnyPublisher<Measurement<UnitSpeed>, Never> {
        $speeds.flatMap { speeds in speeds.publisher }.eraseToAnyPublisher()
    }
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        if locationManager.authorizationStatus == .notDetermined {
            locationAccessIsDenied = true
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func startLocationServices() {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            isRecording = true
            locationManager.startUpdatingLocation()
        }
    }

    func stopLocationServices() {
        isRecording = false
        locationManager.stopUpdatingLocation()
        endLocation = locations.last
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            locationAccessIsDenied = false
            if isRecording {
                locationManager.startUpdatingLocation()
            }
        } else {
            locationAccessIsDenied = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latest = locations.first else { return }
        self.locations.append(latest)
        if previousLocation == nil {
            previousLocation = latest
            distances.append(Measurement.init(value: 0, unit: UnitLength.meters))
        } else {
            let distance = previousLocation?.distance(from: latest) ?? 0
            totalDistance += distance
            distances.append(Measurement.init(value: self.totalDistance, unit: UnitLength.meters))
            previousLocation = latest
        }
        speeds.append(Measurement.init(value: latest.speed, unit: UnitSpeed.metersPerSecond))
        altitudes.append(Measurement.init(value: latest.altitude, unit: UnitLength.meters))
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let clError = error as? CLError else { return }
        switch clError {
        case CLError.denied:
            locationAccessIsDenied = true
        case CLError.promptDeclined:
            locationAccessIsDenied = true
        default:
            locationAccessThrowsError = true
            locationAccessError = clError.localizedDescription
      }
    }
}
