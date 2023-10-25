//
//  LocationAnnotationView.swift
//  Fitness
//
//  Created by Imen Ksouri on 06/10/2023.
//

import Foundation
import MapKit

class LocationAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            frame = CGRect(origin: .zero, size: CGSize(width: 25, height: 25))
            layer.cornerRadius = 12.5
            layer.borderWidth = 2
        }
    }
}
