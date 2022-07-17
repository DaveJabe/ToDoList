//
//  UpdateItemCellDelegate.swift
//  ToDoList
//
//  Created by David Jabech on 7/17/22.
//

import Foundation

protocol UpdateItemCellDelegate: AnyObject {
    var newTitle: String { get set }
    var newCompletion: Bool { get set }
}
