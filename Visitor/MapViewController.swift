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
    
/*    :(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
    {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    }*/
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
