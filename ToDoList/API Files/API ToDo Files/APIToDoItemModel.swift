//
//  APIToDoItem.swift
//  ToDoList
//
//  Created by David Jabech on 7/18/22.
//

import Foundation

struct APIToDoItem: Codable, JSONDecodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
