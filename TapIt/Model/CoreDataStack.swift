//
//  CoreDataStack.swift
//  TapIt
//
//  Created by Michael Flowers on 4/26/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
//step 1
import CoreData

enum CoreDataStack {
    //step2
    //create a container to hold the stack
    static let container: NSPersistentContainer = {
        //create this container to be run later, when someone asks for it instead of immediately
        let container = NSPersistentContainer(name: "CoreDataModel")
        //step 3 tell the container what to do
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //step 4 create the context (MOC)
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
