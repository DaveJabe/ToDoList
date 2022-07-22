//
//  Constants.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import UIKit

struct Constants {
    
    static let semibold = UIFont.systemFont(ofSize: 20, weight: .semibold)
    static let smallFont = UIFont.systemFont(ofSize: 15)
    static let cornerRadius: CGFloat = 15
    
    static let width: CGFloat = 250
    static let smallWidth: CGFloat = 50
    static let height: CGFloat = 60
    static let padding: CGFloat = 20
    static let smallPadding: CGFloat = 15
}

struct URLString {
    static let todos = "https://jsonplaceholder.typicode.com/todos/"
    static let comments = "https://jsonplaceholder.typicode.com/comments"
}

struct SFSymbol {
    static let incomplete = "circle"
    static let complete = "circle.circle.fill"
    static let homeTab = "house"
    static let APITab = "app.connected.to.app.below.fill"
    static let profileTab = "person.fill"
    static let editTable = "tablecells.badge.ellipsis"
    static let plus = "plus"
    static let sort = "arrow.up.arrow.down"
}

