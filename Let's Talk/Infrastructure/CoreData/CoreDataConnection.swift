//
//  CoreDataConnection.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 11/07/23.
//

import CoreData

struct CoreDataConnection {
    static let shared = CoreDataConnection()
    let container: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "Let_s_Talk")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
