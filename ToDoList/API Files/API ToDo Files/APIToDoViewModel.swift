//
//  APIToDoViewModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/18/22.
//

import Foundation

protocol APIToDoDelegate: AnyObject {
    func didGetData()
}

class APIToDoViewModel {
    
    typealias Completion = (() -> ())?
    
    private var models = [APIToDoItem]()
    
    private let handler = APIHandler.shared
    
    private weak var delegate: APIToDoDelegate?
    
    var getCount: Int {
        return models.count
    }
    
    init(delegate: APIToDoDelegate) {
        self.delegate = delegate
        
    }
    
    func getDataFromAPIHandler(completion: Completion) {
        handler.getDataFromAPI(urlString: "https://jsonplaceholder.typicode.com/todos/") { (result: Result<[APIToDoItem], Error>) in
            
            switch result {
                
            case .success(let models):
                self.models = models
                self.delegate?.didGetData()
                completion?()
                
            case .failure(let failure):
                print(failure.localizedDescription)
                completion?()
            }
        }
    }
    
    func getID(forItemAt index: Int) -> Int {
        return models[index].id
    }
    
    func getTitle(forItemAt index: Int) -> String {
        guard index < models.count else {
            return ""
        }
        return models[index].title
    }
    
    func getIsCompleted(forItemAt index: Int) -> Bool {
        return models[index].completed
    }
}
