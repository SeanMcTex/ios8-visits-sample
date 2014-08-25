//
//  VisitManager.swift
//  Visitor
//
//  Created by Sean McMains on 8/25/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class VisitManager: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    func beginMonitoring() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringVisits()
    }

    func endMonitoring() {
        let locationManager = CLLocationManager()
        locationManager.stopMonitoringVisits()
    }
    
    func locationManager(manager: CLLocationManager!, didVisit visit: CLVisit!) {
        print("Visit: \(visit)")
        self.saveVisit(visit)
    }
    
    func saveVisit(visit: CLVisit) {
        let isDepartureVisit = visit.departureDate != NSDate.distantFuture() as? NSDate
        if ( isDepartureVisit ) {
            let app = UIApplication.sharedApplication().delegate as AppDelegate
            if let context = app.managedObjectContext {
                let testLocation = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context) as Visit
                
                testLocation.latitude = visit.coordinate.latitude
                testLocation.longitude = visit.coordinate.longitude
                testLocation.arrivalDate = visit.arrivalDate
                testLocation.departureDate = visit.departureDate
                testLocation.accuracy = visit.horizontalAccuracy
                
                var error :NSError?
                if ( context.save(&error) ) {
                    print("Success\n")
                    self.sendNewDataNotification()
                } else  {
                    print("Problem: \(error!.description)\n")
                }
            }
        }
    }
    
    func sendNewDataNotification() {
        NSNotificationCenter.defaultCenter().postNotificationName("newData", object: nil)
    }
}
