//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by David Jabech on 7/18/22.
//

import Foundation
import CoreData

class CoreDataStack {
        
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataKey.nameForContainer)
        
        container.loadPersistentStores { description, error in
            guard error == nil else {
                print(CoreDataError.failedToLoadPersistentStores.localizedDescription)
                return
            }
        }
        return container
    }()
    
    public init() {}
    
    func fetchData(orderBy sortOption: String) -> [NSManagedObject] {
        
        let managedContext = persistentContainer.viewContext
        
        let sortDescriptor = getSortDescriptor(sortOption: sortOption)
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataKey.entityName)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let models = try managedContext.fetch(fetchRequest)
            return models
        }
        catch {
            print(CoreDataError.failedToFetchData.rawValue)
            return []
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
        }
        catch {
            print(CoreDataError.failedToSaveData.localizedDescription)
        }
    }
    
    private func getSortDescriptor(sortOption: String) -> NSSortDescriptor {
        switch sortOption {
        case SortOption.forward.option:
            return NSSortDescriptor(key: CoreDataKey.titleKey, ascending: true)
        case SortOption.reverse.option:
            return NSSortDescriptor(key: CoreDataKey.titleKey, ascending: false)
        case SortOption.completed.option:
            return NSSortDescriptor(key: CoreDataKey.isCompletedKey, ascending: false)
        case SortOption.incomplete.option:
            return NSSortDescriptor(key: CoreDataKey.isCompletedKey, ascending: true)
        default:
            return NSSortDescriptor()
        }
    }
    
    func insertNewEntity(title: String, isCompleted: Bool) -> ToDoItem? {
        guard let description = NSEntityDescription.entity(forEntityName: CoreDataKey.entityName, in: persistentContainer.viewContext) else {
            print(CoreDataError.failedToCreateEntityDescription.localizedDescription)
            return nil
        }
        
        let newItem = NSManagedObject(entity: description, insertInto: persistentContainer.viewContext)
        newItem.setValue(title, forKeyPath: CoreDataKey.titleKey)
        newItem.setValue(isCompleted, forKeyPath: CoreDataKey.isCompletedKey)
        
        saveContext()
        
        return newItem as? ToDoItem
    }
    
    func removeEntity(_ entity: NSManagedObject) {
        persistentContainer.viewContext.delete(entity)
        saveContext()
    }
    
    func updateEntity(_ entity: NSManagedObject, newTitle: String, newIsCompleted: Bool){
        entity.setValue(newTitle, forKeyPath: CoreDataKey.titleKey)
        entity.setValue(newIsCompleted, forKeyPath: CoreDataKey.isCompletedKey)
        saveContext()
    }
}
