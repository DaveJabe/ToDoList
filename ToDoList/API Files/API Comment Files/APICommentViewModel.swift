//
//  APICommentViewModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/19/22.
//

import Foundation

protocol APICommentDelegate: AnyObject {
    func didGetData()
}

class APICommentViewModel {
    
    private var models = [APIComment]()
    
    private weak var delegate: APICommentDelegate?
    
    private let handler = APIHandler.shared
    
    var getCount: Int {
        return models.count
    }
    
    init(delegate: APICommentDelegate) {
        
        self.delegate = delegate
        
        handler.getDataFromAPI(urlString: "https://jsonplaceholder.typicode.com/comments") { (result: Result<[APIComment], Error>) in
            switch result {
            case .success(let models):
                self.models = models
                self.delegate?.didGetData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getBody(forItemAt index: Int) -> String {
        return models[index].body
    }
}
