//
//  UpdateItemViewModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/17/22.
//

import UIKit

class UpdateItemCellViewModel: UpdateItemCellDelegate {
    
    private var models: [UpdateItemCellType] = []
    
    init(itemTitle: String, isCompleted: Bool) {
        self.newTitle = itemTitle
        self.newCompletion = isCompleted
        configureModels(itemTitle: itemTitle, isCompleted: isCompleted)
    }
    
    var newTitle: String
    
    var newCompletion: Bool
    
    private func configureModels(itemTitle: String, isCompleted: Bool) {
        models.append(UpdateItemCellType.textFieldCell(model: TextFieldCellModel(title: "Title", textFieldText: itemTitle)))
        models.append(UpdateItemCellType.toggleCell(model: ToggleCellModel(title: "Completed", isOn: isCompleted)))
    }
    
    func cellCount() -> Int {
        return models.count
    }
    
    func cellType(at index: Int) -> UpdateItemCellType {
        return models[index]
    }
}

