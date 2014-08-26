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
    
    func locationManager(manager: CLLocationManager!, didVisit clVisit: CLVisit!) {
        if let visit = self.getVisitFromCLVisit( clVisit ) {
            visit.save()
            self.geocodeVisit( visit )            
        }
    }
    
    func geocodeVisit( visit: Visit ) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: visit.latitude, longitude: visit.longitude)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) -> Void in
            let placemark = placemarks[0] as CLPlacemark
            visit.placeName = placemark.name
            visit.save()
        }
    }
    
    func getVisitFromCLVisit(visit: CLVisit) -> Visit? {
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
                
                return testLocation
            }
        }
        return nil
    }
    
}
