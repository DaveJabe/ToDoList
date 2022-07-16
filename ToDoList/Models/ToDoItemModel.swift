//
//  ToDoItemModel.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import Foundation

struct ToDoItem: Comparable {
    static func < (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.title < rhs.title
    }
    
    var title: String
    var completed: Bool = false
}

struct SampleData {
    static var toDoItems = [ToDoItem(title: "run"),
                            ToDoItem(title: "cook"),
                            ToDoItem(title: "homework"),
                            ToDoItem(title: "read"),
                            ToDoItem(title: "write"),
                            ToDoItem(title: "clean house")]
}
