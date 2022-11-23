//
//  Constants.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import UIKit

struct Constants {
    
    static let semibold = UIFont.systemFont(ofSize: 20, weight: .semibold)
    static let largeFont = UIFont.systemFont(ofSize: 40, weight: .medium)
    static let smallFont = UIFont.systemFont(ofSize: 15)
    static let cornerRadius: CGFloat = 15
    
    static let width: CGFloat = 250
    static let smallWidth: CGFloat = 50
    static let height: CGFloat = 60
    static let padding: CGFloat = 20
    static let smallPadding: CGFloat = 15
}

struct SFSymbol {
    static let incomplete = "circle"
    static let complete = "circle.circle.fill"
    static let homeTab = "house"
    static let focusTab = "brain.head.profile"
    static let profileTab = "person.fill"
    static let editTable = "tablecells.badge.ellipsis"
    static let plus = "plus"
    static let sort = "arrow.up.arrow.down"
    static let pomodoroComplete = "checkmark.diamond"
}

