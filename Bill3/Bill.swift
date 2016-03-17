//
//  Bill.swift
//  Bill3
//
//  Created by superMT on 16/3/14.
//  Copyright © 2016年 superMT. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Bill {
    var note = "this is a note";
    var date = NSDate();
    var tag = "";
    var type = "收入";
    var money = 0.0;
}


/*
class CoreDAO : NSObject{
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "MS-BL.superMT.coredata" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("bill", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
}

class BillDAO:CoreDAO{
    func findALL()->NSMutableArray{
        let cxt = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("Bill", inManagedObjectContext: cxt)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity;
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        var sortDescriptors:NSArray = NSArray(object: sortDescriptor)
        fetchRequest.sortDescriptors = sortDescriptors as! [NSSortDescriptor]
        var error: NSError? = nil;
        var ListData = cxt.executeFetchRequest(fetchRequest, error: &error)
        var resListData = NSMutableArray()
        for item in ListData{
            var mo = item as NSManagedObject
            var temp = Bill()
            temp.date = mo.valueForKey("date") as NSDate!
            temp.tag = mo.valueForKey("tag") as NSString!
            temp.type = mo.valueForKey("type") as NSString!
            temp.note = mo.valueForKey("note") as NSString!
            money = mo.valueForKey("money") as Double!
            resListData.addObject(temp)
        }
        return resListData
    }

}
*/
