//
//  ToDoItemViewModel.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import Foundation

class ToDoItemViewModel {
    
    // MARK: - Properties
    
    private var models = [ToDoItem]()
    
    var itemCount: Int {
        return models.count
    }
    
    init() {
        models = SampleData.toDoItems
    }
    
    // MARK: - Private Methods
    
    private func isValidTitle(_ string: String) -> Bool {
        return !string.isEmpty
    }
    
    private func insertItem(item: ToDoItem, at index: Int) {
        models.insert(item, at: index)
    }
    
    // MARK: - Methods
    
    func item(at index: Int) -> ToDoItem {
        return models[index]
    }
    
    func title(forItemAt index: Int) -> String {
        return models[index].title
    }
    
    func completionStatus(forItemAt index: Int) -> Bool {
        return models[index].completed
    }
    
    func addItem(_ title: String, completion: (Bool) -> Void) {
        if isValidTitle(title) {
            models.append(ToDoItem(title: title))
            completion(true)
        }
        else {
            completion(false)
        }
    }
    
    func removeItem(at index: Int, completion: (() -> Void)?) {
        models.remove(at: index)
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
            models[index] = ToDoItem(title: title, completed: completed)
            completion(true)
        }
        else {
            completion(false)
        }
    }
    
    func sortItems(by param: SortOptionName) {
        switch param {
        case .forward:
            models.sort()
        case .reverse:
            models.sort(by: { $0.title > $1.title })
        case .completed:
            models.sort(by: { $0.completed && !$1.completed })
        case .incomplete:
            models.sort(by: { !$0.completed && $1.completed })
        }
    }
    
}

    // MARK: - Delegate

extension ToDoItemViewModel: ToDoCellDelegate {
    func toDoItemWasToggled(on: Bool, index: Int) {
        models[index].completed = on
    }
}
