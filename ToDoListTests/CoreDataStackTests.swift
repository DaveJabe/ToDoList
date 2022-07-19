//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by David Jabech on 7/18/22.
//

import XCTest
import CoreData
// Very important step; you can't test code otherwise
@testable import ToDoList

class CoreDataStackTests: XCTestCase {
    
    var coreDataStack: CoreDataStack?
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack.init()
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
    }
    
    // MARK: - Tests

    func test_insertEntity() {
        
        let entity1 = coreDataStack!.insertNewEntity(title: "Entity 1", isCompleted: false)
        XCTAssertNotNil(entity1)
        
        let entity2 = coreDataStack!.insertNewEntity(title: "this is a test", isCompleted: false)
        XCTAssertNotNil(entity2)
       
        let entity3 = coreDataStack!.insertNewEntity(title: "here's another: 😎🤩🙏🏻", isCompleted: false)
        XCTAssertNotNil(entity3)
    }
    
    func test_fetchAllEntities() {
        
        test_insertEntity()
                
        let data = coreDataStack!.fetchData(orderBy: SortOption.forward.option)
        XCTAssertEqual(data.count, 3, "We added three entities in the previous test, so we should have 3 entities in our fetch results")
    }
    
    func test_removeEntity() {
        
        test_insertEntity()
        
        let data = coreDataStack!.fetchData(orderBy: SortOption.forward.option)
        let itemToRemove = data[0]
        
        let count = data.count
        
        coreDataStack?.removeEntity(itemToRemove)
         
        XCTAssertEqual(coreDataStack!.fetchData(orderBy: SortOption.forward.option).count, count-1, "Since we removed an item, coreData should return 1 less item than before")
        
    }
    
    func test_updateEntity() {
        
        test_insertEntity()
        
        let data = coreDataStack!.fetchData(orderBy: SortOption.forward.option)
        let itemToUpdate = data[0]
        coreDataStack?.updateEntity(itemToUpdate, newTitle: "title was updated", newIsCompleted: false)
        
        XCTAssertEqual(itemToUpdate.value(forKeyPath: CoreDataKey.titleKey) as! String, "title was updated", "This test ensures that the item's title is updated")
        
    }
}
