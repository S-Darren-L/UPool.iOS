//
//  LocalRepositoryService.swift
//  UPool
//
//  Created by Darren on 2017-05-29.
//  Copyright © 2017 UPool.iOS. All rights reserved.
//

import Foundation
import CoreData

class LocalRepositoryService {
    
    private init() {
    }
    
    class func getContext() -> NSManagedObjectContext {
        return LocalRepositoryService.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "APP_NAME".localized)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    class func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
