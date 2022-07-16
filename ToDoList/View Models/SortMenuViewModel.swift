//
//  SortMenuViewModel.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import Foundation

class SortMenuViewModel {
    
    var sortParameters: [[SortOptionName:SortOptionIcon]] = [SortOption.forward,
                                                                   SortOption.reverse,
                                                                   SortOption.completed,
                                                                   SortOption.incomplete]
    
    func sortParameter(at index: Int) -> SortOptionName {
        guard let param = sortParameters[index].first?.key else {
            return .forward
        }
        return param
    }
    
    func parameterName(at index: Int) -> String {
        guard let name = sortParameters[index].first?.key.rawValue else {
            return ""
        }
        return name
    }
    
    func paramaterIcon(at index: Int) -> String {
        guard let icon = sortParameters[index].first?.value.rawValue else {
            return ""
        }
        return icon
    }
}
