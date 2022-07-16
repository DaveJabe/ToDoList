//
//  SortOptionModel.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/16/22.
//

import Foundation

enum SortOptionName: String {
    case forward = "Ascending"
    case reverse = "Descending"
    case completed = "Complete"
    case incomplete = "Incomplete"
}

enum SortOptionIcon: String {
    case forward = "arrow.up"
    case reverse = "arrow.down"
    case completed = "checkmark.circle.fill"
    case incomplete = "circle"
}

struct SortOption {
    static let forward = [SortOptionName.forward:SortOptionIcon.forward]
    static let reverse = [SortOptionName.reverse:SortOptionIcon.reverse]
    static let completed = [SortOptionName.completed:SortOptionIcon.completed]
    static let incomplete = [SortOptionName.incomplete:SortOptionIcon.incomplete]
}
