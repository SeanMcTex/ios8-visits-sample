//
//  MapViewController.swift
//  
//
//  Created by Sean McMains on 8/25/14.
//
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var visit: Visit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMap()
    }
    
    func setupMap() {
        if let visit = self.visit {
            let coordinates = CLLocationCoordinate2DMake(visit.latitude, visit.longitude)
            let region = MKCoordinateRegionMakeWithDistance(coordinates, 200, 200)
            self.mapView.setRegion(self.mapView.regionThatFits(region), animated: false)

            var point = MKPointAnnotation()
            point.coordinate = coordinates
            self.mapView.addAnnotation(point)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
