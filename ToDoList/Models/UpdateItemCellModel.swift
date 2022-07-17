//
//  UpdateItemCellModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/17/22.
//

import Foundation


enum UpdateItemCellType {
    case textFieldCell(model: TextFieldCellModel)
    case toggleCell(model: ToggleCellModel)
}

struct TextFieldCellModel {
    let title: String
    let textFieldText: String
}

struct ToggleCellModel {
    let title: String
    let isOn: Bool
}
