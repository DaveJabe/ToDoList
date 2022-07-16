//
//  CoreDataErrors.swift
//  ToDoList
//
//  Created by David Jabech on 7/16/22.
//

import Foundation

enum CoreDataError: String, Error {
    case failedToGetAppDelegate = "Failed to downcast App Delegate"
    case failedToFetchData = "Failed to fetch data"
    case failedToSaveData = "Failed to save data"
    case failedToCreateEntityDescription = "Failed to create entity description"
    case errorGettingTitle = "Error getting title for ToDoItem"
    case errorGettingCompleted = "Error getting completion status for ToDoItem"
}
