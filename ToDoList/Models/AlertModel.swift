//
//  AlertModel.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import UIKit

struct AlertModel {
    let title: String?
    let message: String?
    let style: UIAlertController.Style
}

struct AlertActionModel {
    let title: String
    let style: UIAlertAction.Style
    let handler: ((UIAlertAction) -> Void)?
}

struct Alert {
    static let addItemAlert = AlertModel(title: "Add New Item",
                                         message: "Type the title for your new to do item below.",
                                         style: .alert)
    
    static let emptyTextAlert = AlertModel(title: "Could not add new item",
                                           message: "Please enter 1 or more characters",
                                           style: .alert)
}

struct AlertAction {
    static let ok = AlertActionModel(title: "Ok",
                                     style: .default,
                                     handler: nil)
    
    static let cancel = AlertActionModel(title: "Cancel",
                                         style: .destructive,
                                         handler: nil)
}

