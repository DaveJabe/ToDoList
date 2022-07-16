//
//  SortMenuViewModel.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import Foundation

class SortMenuViewModel {
    
    private var sortOptions = [SortOption.forward,
                               SortOption.reverse,
                               SortOption.completed,
                               SortOption.incomplete]
    
    var sortOptionsCount: Int {
        return sortOptions.count
    }
    
    func sortOptionName(at index: Int) -> String {
        return sortOptions[index].option
    }
    
    func sortOptionIcon(at index: Int) -> String {
        return sortOptions[index].iconName
    }
}
