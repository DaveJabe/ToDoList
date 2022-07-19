//
//  APIHandler.swift
//  ToDoList
//
//  Created by David Jabech on 7/18/22.
//

import Foundation

class APIHandler {
    static let shared = APIHandler()
    
    private init() {}
    
    func getDataFromAPI(completion: @escaping ([APIToDoModel]) -> Void) {
        
        // 1. Create URL
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            print("Failed to create URL")
            return
        }
        
        // 2. Create URLSessionDataTask (parse data, check response, handle errors)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error fetching data from API... status code: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                return
            }
            
            do {
                let results = try JSONDecoder().decode([APIToDoModel].self, from: data)
                completion(results)
            }
            catch {
                print("Could not decode data into APIToDoModel array")
            }
        }
        
        // 3. Resume task
        task.resume()
    }
}
