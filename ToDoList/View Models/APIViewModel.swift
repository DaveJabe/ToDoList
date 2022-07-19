//
//  APIViewModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/18/22.
//

import Foundation

class APIViewModel {
    
    private var models = [APIToDoModel]()
    
    private let handler = APIHandler.shared
    
    var getCount: Int {
        return models.count
    }
    
    init() {
        handler.getDataFromAPI { [weak self] results in
            self?.models = results
        }
    }
    
    func titleForItem(at index: Int) -> String {
        return models[index].title
    }
    
    func isCompletedForItem(at index: Int) -> Bool {
        return models[index].completed
    }
}
