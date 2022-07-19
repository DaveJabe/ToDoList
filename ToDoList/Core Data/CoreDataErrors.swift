//
//  CoreDataErrors.swift
//  ToDoList
//
//  Created by David Jabech on 7/16/22.
//

import Foundation

enum CoreDataError: String, Error {
    case failedToLoadPersistentStores = "Failed to load persistent stores"
    case failedToInsertEntity = "Failed to insert new entity"
    case failedToUpdateEntity = "Failed to update entity"
    case failedToFetchData = "Failed to fetch data... returning empty array"
    case failedToSaveData = "Failed to save data"
    case failedToCreateEntityDescription = "Failed to create entity description"
    case errorGettingTitle = "Error getting title for ToDoItem"
    case errorGettingCompleted = "Error getting completion status for ToDoItem"
}
