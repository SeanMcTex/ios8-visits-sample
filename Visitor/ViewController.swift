//
//  ViewController.swift
//  Visitor
//
//  Created by Sean McMains on 8/21/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var visitsArray:[Visit] = []
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchVisitsFromStore()
        self.setupNavigation()
        self.setupNotifications()
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fetchVisitsFromStore", name: "newData", object: nil)
    }
    
    func setupNavigation() {
        self.navigationItem.title = "Locations Visited"
        let trashButtonItem = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "didTapTrashButton")
        self.navigationItem.rightBarButtonItem = trashButtonItem
    }
    
    func didTapTrashButton() {
        self.deleteAllVisits()
        self.fetchVisitsFromStore()
    }
    
    func deleteAllVisits() {
        let app = UIApplication.sharedApplication().delegate as AppDelegate
        if let context = app.managedObjectContext {
            for visit in self.visitsArray {
                context.deleteObject(visit)
            }
            context.save(nil)
        }
        self.fetchVisitsFromStore()
    }
    
    func fetchVisitsFromStore() {
        let app = UIApplication.sharedApplication().delegate as AppDelegate
        if let context = app.managedObjectContext {
            
            let fetchRequest = NSFetchRequest()
            let entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
            fetchRequest.entity = entityDescription
            var error :NSError?
            self.visitsArray = context.executeFetchRequest(fetchRequest, error: &error) as [Visit]
        }
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Table View Delegate Methods
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.visitsArray.count 
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("VisitCellIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        let visit = self.visitsArray[ indexPath.row ]
        if let placeName = visit.placeName? {
            cell.textLabel.text = placeName
        } else {
            cell.textLabel.text = "Location Unknown"
        }
        cell.detailTextLabel.text = self.durationTextForVisit(visit)
        
        return cell
    }
    
    func durationTextForVisit( visit: Visit ) -> NSString {
        let interval = visit.departureDate.timeIntervalSinceDate( visit.arrivalDate )
        let minutes = Int( floor( interval / 60 ) )
        let hours = Int( floor( interval / ( 60 * 60 ) ) )
        
        var components = NSDateComponents()
        components.minute = minutes
        components.hour = hours
        
        let formatter = NSDateComponentsFormatter()
        formatter.unitsStyle = .Positional
        return formatter.stringFromDateComponents( components )
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let indexPath = self.tableView.indexPathForSelectedRow()
        let visit = self.visitsArray[ indexPath.row ]
        let destinationViewController = segue.destinationViewController as MapViewController
        destinationViewController.visit = visit
    }
    
    


}

