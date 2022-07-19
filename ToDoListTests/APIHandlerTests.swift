//
//  APIHandlerTests.swift
//  ToDoListTests
//
//  Created by David Jabech on 7/19/22.
//

import XCTest
@testable import ToDoList


class APIHandlerTests: XCTestCase {
    
    var urlSession: URLSession!
    
    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        urlSession = URLSession(configuration: configuration)
    }
    
    func test_APIHandlerInit() {
        XCTAssertNotNil(APIHandler.shared, "Shared APIHandler singleton should not be nil")
    }
    
    func test_getDataFromAPI() {
        
        let handler = APIHandler(session: urlSession)
        
        let expectation = XCTestExpectation(description: "result")
        
        // The URL should return us 200 to do items
        
        handler.getDataFromAPI(urlString: "https://jsonplaceholder.typicode.com/todos/") { (result: Result<[APIToDoItem], Error>) in
            switch result {
            case .success(let todos):
                XCTAssertEqual(todos.count, 200, "The url should return us 200 items")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Failed to decode data into type [APIToDoItem]... \(failure)")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
