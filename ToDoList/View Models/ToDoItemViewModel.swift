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
    
    private var models: [NSManagedObject]
    
    private let coreDataStack = CoreDataStack()
    
    var itemCount: Int {
        return models.count
    }
    
    init() {
        models = coreDataStack.fetchData(orderBy: SortOption.forward.option)
    }
    
    // MARK: - Private Methods

    private func isValidTitle(_ string: String) -> Bool {
        return !string.isEmpty
    }
    
    private func insertItem(item: NSManagedObject, at index: Int) {
        models.insert(item, at: index)
    }
    
    // MARK: - Methods
    
    func isEmpty() -> Bool {
        return models.isEmpty
    }
    
    func item(at index: Int) -> NSManagedObject {
        return models[index]
    }
    
    func title(forItemAt index: Int) -> String {
        guard let title = models[index].value(forKeyPath: CoreDataKey.titleKey) as? String else {
            print(CoreDataError.errorGettingTitle.localizedDescription)
            return ""
        }
        return title
    }
    
    func isCompleted(itemAt index: Int) -> Bool {
        guard let completed = models[index].value(forKeyPath: CoreDataKey.isCompletedKey) as? Bool else {
            print(CoreDataError.errorGettingCompleted.localizedDescription)
            return false
        }
        return completed
    }
    
    func addItem(_ title: String, completion: (Bool) -> Void) {
        if isValidTitle(title) {

            guard let item = coreDataStack.insertNewEntity(title: title, isCompleted: false) else {
                print(CoreDataError.failedToInsertEntity.localizedDescription)
                return
            }
            
            models.append(item)
            completion(true)
        }
        else {
            completion(false)
        }
    }
    
    func removeItem(at index: Int, completion: (() -> Void)?) {
        let itemToDelete = models.remove(at: index)
        
        coreDataStack.removeEntity(itemToDelete)
        
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
            
            coreDataStack.updateEntity(models[index], newTitle: title, newIsCompleted: completed)
            
            completion(true)
        }
        else {
            completion(false)
        }
    }
    
    func sortItems(by sortOption: String) {
        models = coreDataStack.fetchData(orderBy: sortOption)
    }
}

    // MARK: - Delegates

extension ToDoItemViewModel: ToDoCellDelegate {
    func toDoItemWasToggled(on: Bool, index: Int) {
        models[index].setValue(on, forKeyPath: CoreDataKey.isCompletedKey)
        coreDataStack.saveContext()
    }
}
