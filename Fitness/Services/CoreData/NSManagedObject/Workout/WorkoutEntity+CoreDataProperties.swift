//
//  WorkoutEntity+CoreDataProperties.swift
//  Fitness
//
//  Created by Imen Ksouri on 22/10/2023.
//
//

import Foundation
import CoreData
import CoreLocation

extension WorkoutEntity {
    @NSManaged public var uuid: UUID
    @NSManaged public var date: Date?
    @NSManaged public var type: Int16
    @NSManaged public var routeLatitudes: [CLLocationDegrees]?
    @NSManaged public var routeLongitudes: [CLLocationDegrees]?
    @NSManaged public var duration: TimeInterval
    @NSManaged public var distances: [Double]?
    @NSManaged public var speeds: [Double]?
    @NSManaged public var altitudes: [Double]?
    @NSManaged public var distance: DistanceEntity?
    @NSManaged public var speed: SpeedEntity?
    @NSManaged public var calories: CalorieEntity?
    @NSManaged public var steps: StepEntity?
}
