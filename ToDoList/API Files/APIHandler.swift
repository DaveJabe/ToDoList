//
//  APIHandler.swift
//  ToDoList
//
//  Created by David Jabech on 7/18/22.
//

import Foundation

class APIHandler {
    
    static let shared = APIHandler()
        
    let session: URLSession
        
    init(session: URLSession = .shared) {
        self.session = session
    }    
    
    func getDataFromAPI<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
                
        guard let url = URL(string: urlString) else {
            print("Failed to create URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error fetching data from API... status code: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }
            catch(let decodingError) {
                completion(.failure(decodingError))
            }
        }
        task.resume()
    }
}
