//
//  UserDefault.swift
//  ToDoList
//
//  Created by David Jabech on 7/23/22.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    let container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
        container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    enum Keys {
        static let workLength = "workLength"
        static let breakLength = "breakLength"
    }
    
    @UserDefault(key: UserDefaults.Keys.workLength, defaultValue: 1500) // 1500
    static var workLength: Int
    
    @UserDefault(key: UserDefaults.Keys.breakLength, defaultValue: 300) // 300
    static var breakLength: Int
}
