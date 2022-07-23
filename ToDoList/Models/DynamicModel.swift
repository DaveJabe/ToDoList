//
//  DynamicModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/22/22.
//

import Foundation

class Dynamic<T> {
    typealias Listener = ((T) -> Void)
    var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
