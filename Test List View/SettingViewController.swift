//
//  SettingViewController.swift
//  Test List View
//
//  Created by Alexsander  on 10/30/15.
//  Copyright © 2015 Alexsander Khitev. All rights reserved.
//

import UIKit
import CoreData

class SettingViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultsController: NSFetchedResultsController!
    
    @IBOutlet weak var historyCell: UITableView!
    @IBOutlet weak var buttonOk: UIButton!
    @IBOutlet weak var rowTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!

    @IBAction func save(sender: UIButton) {
        let historyEntity = NSEntityDescription.insertNewObjectForEntityForName("History", inManagedObjectContext: managedObjectContext) as! History
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            
        }
        let content = fetchedResultsController.fetchedObjects?.first as! Digit
        print(content.number, content.color, content)
        let colorString = colorTextField.text!
        let colorDigit = Double(colorString)!
        content.color = NSNumber(double: colorDigit)
        
        // history
        let currentRow = rowTextField.text!
        let superInt = Int16(currentRow)!
        historyEntity.colorHistory = NSNumber(double: colorDigit)
        historyEntity.dateHistory = NSDate()
        historyEntity.digitHistory = NSNumber(short: superInt)
        
        do {
            try managedObjectContext.save()
        } catch {
            
        }
        
    }
    
    func fetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Digit")
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        fetchRequest.fetchBatchSize = 100
        let stringDigit = rowTextField.text!
        let searchDigit = Int16(stringDigit)!
        let number = NSNumber(short: searchDigit)
        fetchRequest.predicate = NSPredicate(format: "number contains[c] %@", number)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func fetchRequestSecond() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "History")
        let sortDescriptor = NSSortDescriptor(key: "dateHistory", ascending: true)
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 100
        return fetchRequest
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequestSecond(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MainTableViewCell
        let data = fetchedResultsController.objectAtIndexPath(indexPath) as! History
        let color = data.colorHistory! as Double
        
        let gradient = CAGradientLayer()
        gradient.frame.size = cell.colorButton.frame.size
        gradient.colors = [
            UIColor.greenColor().CGColor,
            UIColor.greenColor().CGColor,
            UIColor.blackColor().CGColor,
            UIColor.blackColor().CGColor
        ]
        
        gradient.locations = [0.0, color, color, 1]
        gradient.startPoint = CGPointMake(0.0, 0.5)
        if color == 0.0 {
            gradient.endPoint = CGPointMake(0, 0.5)
        } else {
            gradient.endPoint = CGPointMake(1, 0.5)
        }
        
        
        
        cell.numberLabel.text = "\(data.digitHistory!)"
        cell.colorButton.layer.insertSublayer(gradient, atIndex: 0)
        
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
