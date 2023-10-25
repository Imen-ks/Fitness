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
    @NSManaged public var route: [CLLocation]?
    @NSManaged public var duration: TimeInterval
    @NSManaged public var distances: [Measurement<UnitLength>]?
    @NSManaged public var speeds: [Measurement<UnitSpeed>]?
    @NSManaged public var altitudes: [Measurement<UnitLength>]?
}
