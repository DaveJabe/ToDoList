//
//  TestCoreDataStack.swift
//  ToDoList
//
//  Created by David Jabech on 7/18/22.
//

import Foundation
import CoreData

class TestCoreDataStack: CoreDataStack {
    
    override init() {
        super.init()
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: CoreDataKey.nameForContainer)
        
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { description, error in
            if let error = error as NSError? {
                fatalError(CoreDataError.failedToLoadPersistentStores.localizedDescription + "... Error: \(error.localizedDescription)")
            }
        })
        
        persistentContainer = container
    }
}
