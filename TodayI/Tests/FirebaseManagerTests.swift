//
//  FirebaseManagerTests.swift
//  TodayITests
//
//  Created by Kemuel Clyde Belderol on 2/11/24.
//

import XCTest
@testable import TodayI 

class FirebaseManagerTests: XCTestCase {
  
  var firebaseManager: FirebaseManager!
  
  override func setUp() {
    super.setUp()
    firebaseManager = FirebaseManager.shared
  }
  
  override func tearDown() {
    firebaseManager = nil
    super.tearDown()
  }

  func testUploadImage() {
    // Given
    let image = Data() // Mock image data
    let year = 2024 // Assuming the year for testing
    
    let expectation = self.expectation(description: "Image upload completed")
    
    // When
    firebaseManager.uploadImage(year: year, with: image) { imageUrl in
      // Then
      XCTAssertNotNil(imageUrl)
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5, handler: nil) // Adjust timeout as needed
  }
  
  func testGetAllMemories() {
    // Given
    let year = 2024 // Assuming the year for testing
    
    let expectation = self.expectation(description: "Memories retrieval completed")
    
    // When
    firebaseManager.getAllMemories(for: year) { memories in
      // Then
      XCTAssertNotNil(memories)
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5, handler: nil) // Adjust timeout as needed
  }
}
