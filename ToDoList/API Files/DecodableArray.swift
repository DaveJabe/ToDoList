//
//  DecodableArray.swift
//  ToDoList
//
//  Created by David Jabech on 7/19/22.
//

import Foundation

protocol JSONDecodable { }

enum DecodableDataType {
    case ToDo([APIToDoItem])
    case Comment([APIComment])
}

struct DecodableArray {
    
    var decodedData: [JSONDecodable]
    
    init(data: Data, type: DecodableDataType) {
        
        var result = [JSONDecodable]()
        
        switch type {
            case .ToDo:
                do {
                    let decoded = try JSONDecoder().decode([APIToDoItem].self, from: data)
                    result = decoded
                }
                catch(let decodingError) {
                    print(decodingError)
                }
                
            case.Comment:
                do {
                    let decoded = try JSONDecoder().decode([APIComment].self, from: data)
                    result = decoded
                }
                catch(let decodingError) {
                    print(decodingError)
                }
            }
            decodedData = result
    }
}
