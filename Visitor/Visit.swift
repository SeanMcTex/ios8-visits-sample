//
//  Visit.swift
//  Visitor
//
//  Created by Sean McMains on 8/22/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import CoreData

// Class Variables are not yet supported. :(
let entityName = "Visit"

class Visit: NSManagedObject {
    

    @NSManaged var accuracy: NSNumber
    @NSManaged var address: String
    @NSManaged var arrivalDate: NSDate
    @NSManaged var departureDate: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var placeName: String

}
