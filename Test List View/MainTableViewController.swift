//
//  MainTableViewController.swift
//  Test List View
//
//  Created by Alexsander  on 10/30/15.
//  Copyright © 2015 Alexsander Khitev. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var array = [Int]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController!
    let userDefault = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("fetch perfrom error")
        }

        if userDefault.boolForKey("check") == false {
        for var x=0; x<100; x++ {
            array.append(x)
            print(x)
            let entity = NSEntityDescription.insertNewObjectForEntityForName("Digit", inManagedObjectContext: managedObjectContext) as! Digit

            let megaInt = Int16(x)
            entity.number = NSNumber(short: megaInt)
            entity.color = NSNumber(double: 0.0)
            do {
                try managedObjectContext.save()
            } catch {
                print("error")
            }
            }
            self.tableView.reloadData()
            userDefault.setBool(true, forKey: "check")
        }
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - function
    func fetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Digit")
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 100
        return fetchRequest
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case NSFetchedResultsChangeType.Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case NSFetchedResultsChangeType.Update:
            tableView.cellForRowAtIndexPath(indexPath!)
        default: break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case NSFetchedResultsChangeType.Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case NSFetchedResultsChangeType.Update:
            break
        default: break
        }
    }
    
  
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellView", forIndexPath: indexPath) as! MainTableViewCell
        
        let data = fetchedResultController.objectAtIndexPath(indexPath) as! Digit
        let colorInfo = data.color! as Double
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = cell.colorButton.frame.size
        gradientLayer.colors = [
            UIColor.greenColor().CGColor,
            UIColor.greenColor().CGColor,
            UIColor.blackColor().CGColor,
            UIColor.blackColor().CGColor
        ]
        gradientLayer.locations = [0.0, colorInfo, colorInfo, 1]
        gradientLayer.startPoint = CGPointMake(0, 0.5)
        
        if colorInfo == 0 {
        gradientLayer.endPoint = CGPointMake(0, 0.5) // black
        } else {
            print("color info != 0")
            gradientLayer.endPoint = CGPointMake(1, 0.5)
        }
        
        cell.numberLabel.text = "\(data.number!)"
        cell.colorButton.layer.insertSublayer(gradientLayer, below: cell.colorButton.titleLabel?.layer)

        return cell
    }

    // MARK: - IBAction func
    
    @IBAction func showSetting(sender: UIButton) {
        performSegueWithIdentifier("setting", sender: self)
    }
 
    // MARK: - Navigation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        performSegueWithIdentifier("result", sender: self)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "result" {
            let dVC = segue.destinationViewController as! DetailViewController
            let index = tableView.indexPathForSelectedRow!
        
            let passedElement = fetchedResultController.objectAtIndexPath(index) as! Digit
            print(passedElement)
            
            dVC.element = passedElement            
        }
    }

}
