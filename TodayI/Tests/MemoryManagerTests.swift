//
//  MemoryManagerTests.swift
//  TodayITests
//
//  Created by Kemuel Clyde Belderol on 2/11/24.
//

import XCTest
import CoreData

@testable import TodayI

class MemoryManagerTests: XCTestCase {
  
  var memoryManager: MemoryManager!
  var container: NSPersistentContainer!
  
  override func setUp() {
    super.setUp()
    
    container = NSPersistentContainer(name: "TodayI")
    container.loadPersistentStores { (_, error) in
      XCTAssertNil(error)
    }
    
    memoryManager = MemoryManager(container: container)
  }
  
  override func tearDown() {
    memoryManager = nil
    container = nil
    
    super.tearDown()
  }
  
  func testSave() {
    // Given
    let memory = Memory(context: container.viewContext)
    memory.id = "Test Memory"
    memory.dateString = Date().toString()
    
    // When
    memoryManager.save()
    
    // Then
    XCTAssertFalse(container.viewContext.hasChanges)
  }
  
  func testDeleteMemory() {
    // Given
    let memory = Memory(context: container.viewContext)
    memory.id = "Test Memory"
    memory.dateString = Date().toString()
    
    // When
    memoryManager.deleteMemory(memory)
    
    // Then
    XCTAssertFalse(container.viewContext.registeredObjects.contains(memory))
    // Additional assertions for FirebaseManager deletion if needed
  }
}
