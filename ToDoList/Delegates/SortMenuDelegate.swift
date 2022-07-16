//
//  SortMenuDelegate.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/16/22.
//

import Foundation

protocol SortMenuDelegate: AnyObject {
    func sortOptionWasSelected(sortOption: String)
}
