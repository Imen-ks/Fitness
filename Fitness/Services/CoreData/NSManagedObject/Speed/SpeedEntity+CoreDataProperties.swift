//
//  SpeedEntity+CoreDataProperties.swift
//  Fitness
//
//  Created by Imen Ksouri on 22/10/2023.
//
//

import Foundation
import CoreData


extension SpeedEntity {
    @NSManaged public var id: UUID
    @NSManaged public var workoutType: Int16
    @NSManaged public var date: Date?
    @NSManaged public var type: Int16
    @NSManaged public var measure: Double
    @NSManaged public var workout: WorkoutEntity
}
