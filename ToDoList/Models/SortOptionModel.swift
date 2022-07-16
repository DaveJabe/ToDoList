//
//  SortOptionModel.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/16/22.
//

import Foundation

enum SortOption {
    static let forward = (option: "A-Z", iconName: "arrow.up")
    static let reverse = (option: "Z-A", iconName: "arrow.down")
    static let completed = (option: "Complete", iconName: "checkmark.circle.fill")
    static let incomplete = (option: "Incomplete", iconName: "circle")
}
