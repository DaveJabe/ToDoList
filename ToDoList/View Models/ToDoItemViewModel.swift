//
//  ToDoItemViewModel.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import UIKit
import CoreData

class ToDoItemViewModel {
    
    // MARK: - Properties
    
    private var models: [NSManagedObject] = []
    
    var itemCount: Int {
        return models.count
    }
    
    init() {
        fetchData(orderBy: SortOption.forward.option)
    }
    
    // MARK: - Private Methods
    
    private func fetchData(orderBy sortOption: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print(CoreDataError.failedToGetAppDelegate.rawValue)
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let sortDescriptor = getSortDescriptor(sortOption: sortOption)
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataKey.entityName)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            models = try managedContext.fetch(fetchRequest)
        }
        catch {
            print(CoreDataError.failedToFetchData.rawValue)
        }
    }
    
    private func saveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print(CoreDataError.failedToGetAppDelegate.rawValue)
            return
        }
        appDelegate.saveContext()
    }
    
    private func isValidTitle(_ string: String) -> Bool {
        return !string.isEmpty
    }
    
    private func insertItem(item: NSManagedObject, at index: Int) {
        models.insert(item, at: index)
    }
    
    private func getSortDescriptor(sortOption: String) -> NSSortDescriptor {
        switch sortOption {
        case SortOption.forward.option:
            return NSSortDescriptor(key: CoreDataKey.titleKey, ascending: true)
        case SortOption.reverse.option:
            return NSSortDescriptor(key: CoreDataKey.titleKey, ascending: false)
        case SortOption.completed.option:
            return NSSortDescriptor(key: CoreDataKey.completedKey, ascending: false)
        case SortOption.incomplete.option:
            return NSSortDescriptor(key: CoreDataKey.completedKey, ascending: true)
        default:
            return NSSortDescriptor()
        }
    }
    
    // MARK: - Methods
    
    func item(at index: Int) -> NSManagedObject {
        return models[index]
    }
    
    func title(forItemAt index: Int) -> String {
        guard let title = models[index].value(forKeyPath: CoreDataKey.titleKey) as? String else {
            print(CoreDataError.errorGettingTitle.rawValue)
            return ""
        }
        return title
    }
    
    func completionStatus(forItemAt index: Int) -> Bool {
        guard let completed = models[index].value(forKeyPath: CoreDataKey.completedKey) as? Bool else {
            print(CoreDataError.errorGettingCompleted.rawValue)
            return false
        }
        return completed
    }
    
    func addItem(_ title: String, completion: (Bool) -> Void) {
        if isValidTitle(title) {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                print(CoreDataError.failedToGetAppDelegate.rawValue)
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            guard let entityDescription = NSEntityDescription.entity(forEntityName: CoreDataKey.entityName, in: managedContext) else {
                print(CoreDataError.failedToCreateEntityDescription.rawValue)
                return
            }
            
            let item = NSManagedObject(entity: entityDescription, insertInto: managedContext)
            item.setValue(title, forKeyPath: CoreDataKey.titleKey)
            
            models.append(item)
            saveData()
            
            completion(true)
        }
        else {
            completion(false)
        }
    }
    
    func removeItem(at index: Int, completion: (() -> Void)?) {
        models.remove(at: index)
        saveData()
        if let completion = completion {
            completion()
        }
    }
    
    func moveItem(at index: Int, to newIndex: Int) {
        let item = models[index]
        removeItem(at: index, completion: nil)
        insertItem(item: item, at: newIndex)
    }
    
    func updateItem(title: String, completed: Bool, at index: Int, completion: (Bool) -> Void) {
        if isValidTitle(title) {
            models[index].setValue(title, forKeyPath: CoreDataKey.titleKey)
            models[index].setValue(completed, forKeyPath: CoreDataKey.completedKey)
            saveData()
            completion(true)
        }
        else {
            completion(false)
        }
    }
    
    func sortItems(by sortOption: String) {
        fetchData(orderBy: sortOption)
    }
}

    // MARK: - Delegate

extension ToDoItemViewModel: ToDoCellDelegate {
    func toDoItemWasToggled(on: Bool, index: Int) {
        models[index].setValue(on, forKeyPath: CoreDataKey.completedKey)
        saveData()
    }
}
