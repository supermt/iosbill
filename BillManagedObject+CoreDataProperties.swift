//
//  BillManagedObject+CoreDataProperties.swift
//  Bill3
//
//  Created by superMT on 16/3/18.
//  Copyright © 2016年 superMT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension BillManagedObject {

    @NSManaged var note: String?
    @NSManaged var date: NSDate?
    @NSManaged var tag: String?
    @NSManaged var type: String?
    @NSManaged var money: NSNumber?

}
