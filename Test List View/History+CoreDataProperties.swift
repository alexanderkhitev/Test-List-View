//
//  History+CoreDataProperties.swift
//  Test List View
//
//  Created by Alexsander  on 11/1/15.
//  Copyright © 2015 Alexsander Khitev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension History {

    @NSManaged var colorHistory: NSNumber?
    @NSManaged var digitHistory: NSNumber?
    @NSManaged var dateHistory: NSDate?

}
