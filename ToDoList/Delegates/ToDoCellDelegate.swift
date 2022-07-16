//
//  ToDoCellDelegate.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import Foundation

protocol ToDoCellDelegate: AnyObject {
    func toDoItemWasToggled(on: Bool, index: Int)
}
