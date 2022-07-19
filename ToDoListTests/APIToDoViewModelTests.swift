//
//  APIToDoViewModelTests.swift
//  ToDoListTests
//
//  Created by David Jabech on 7/19/22.
//

import XCTest
@testable import ToDoList

class APIToDoViewModelTests: XCTestCase {
    
    var viewModel: APIToDoViewModel?
        
    override func setUpWithError() throws {
        viewModel = APIToDoViewModel(delegate: self)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_getEmptyTitle() {
        let testTitle = viewModel?.getTitle(forItemAt: 0)
        XCTAssert(testTitle == "", "testTitle should equal empty string because index is out of bounds (models is empty)")
    }
    
    func test_getDataFromAPIHandler() {
        
        let expectation = XCTestExpectation(description: #function)
        
        viewModel?.getDataFromAPIHandler { [self] in
            XCTAssert(viewModel!.getCount > 0, "We called APIHandler")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getTitle() {
        
        let expectation = XCTestExpectation(description: #function)
        
        viewModel?.getDataFromAPIHandler { [self] in
            XCTAssert(!viewModel!.getTitle(forItemAt: 0).isEmpty, "Because we fetched the API data, the title for the first item should not be nil")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getID() {
        let expectation = XCTestExpectation(description: #function)
        
        viewModel?.getDataFromAPIHandler { [self] in
            XCTAssert(viewModel!.getID(forItemAt: 0) != 0, "Because we fetched the API data, the ID for the first item should have a value")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getIsCompleted() {
        let expectation = XCTestExpectation(description: #function)
        
        viewModel?.getDataFromAPIHandler { [self] in
            XCTAssertNotNil(viewModel?.getIsCompleted(forItemAt: 0), "Because we fetched the API data, the isCompleted bool should have a value")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}

extension APIToDoViewModelTests: APIToDoDelegate {
    func didGetData() {
    }
}
