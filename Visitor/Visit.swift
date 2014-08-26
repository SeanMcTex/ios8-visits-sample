//
//  Visit.swift
//  Visitor
//
//  Created by Sean McMains on 8/22/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// Class Variables are not yet supported. :(
let entityName = "Visit"

class Visit: NSManagedObject {
    

    @NSManaged var accuracy: NSNumber
    @NSManaged var arrivalDate: NSDate
    @NSManaged var departureDate: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var placeName: String?
    
    func save() {
        let app = UIApplication.sharedApplication().delegate as AppDelegate
        if let context = app.managedObjectContext {
            var error :NSError?
            if ( context.save(&error) ) {
                self.sendNewDataNotification()
            } else  {
                print("Couldn't save visit: \(error!.description)\n")
            }
        }
    }
    
    func sendNewDataNotification() {
        NSNotificationCenter.defaultCenter().postNotificationName("newData", object: nil)
    }



}
