//
//  CreateViewModelTests.swift
//  TodayITests
//
//  Created by Kemuel Clyde Belderol on 2/11/24.
//

import XCTest
import CoreData
@testable import TodayI

final class CreateViewModelTests: XCTestCase {

    var createVM: CreateViewModel!
  var container: NSPersistentContainer!
    
    override func setUp() {
      super.setUp()
      
      container = NSPersistentContainer(name: "TodayI")
      container.loadPersistentStores { (_, error) in
        XCTAssertNil(error)
      }
      createVM = CreateViewModel()
    }
    
    override func tearDown() {
      createVM = nil
      container = nil
      super.tearDown()
    }
    
    func testUpdateMemory() {
      // Given
      let memory = Memory(context: container.viewContext)
      createVM.emotion = .Happy // Set vm's emotion
      createVM.selectedDate = "2024-02-11" // Set vm's date
      createVM.textEntry = "This is a journal entry." // Set vm's text entry
      createVM.uiImage = UIImage(named: "angry") // Set vm's image
      
      // When
      createVM.updateMemory(memory)
      
      // Then
      XCTAssertEqual(memory.emotionInt, Int16(Emotion.Happy.rawValue))
      XCTAssertEqual(memory.dateString, "2024-02-11")
      XCTAssertEqual(memory.journalEntry, "This is a journal entry.")
      XCTAssertNotNil(memory.id)
      XCTAssertNotNil(memory.firstImage)
    }
    
    func testSetEmotion() {
      // Given
      let emotionValues: [Double] = [0.1, 0.3, 0.5, 0.7, 0.9, 1.2]
      
      // When & Then
      for value in emotionValues {
        createVM.setEmotion(value)
        switch value {
        case 0..<0.2:
          XCTAssertEqual(createVM.emotion, Emotion.Angry)
        case 0.2..<0.4:
          XCTAssertEqual(createVM.emotion, Emotion.Disgust)
        case 0.4..<0.6:
          XCTAssertEqual(createVM.emotion, Emotion.Happy)
        case 0.6..<0.8:
          XCTAssertEqual(createVM.emotion, Emotion.Sad)
        case 0.8..<1.0:
          XCTAssertEqual(createVM.emotion, Emotion.Worried)
        default:
          XCTAssertEqual(createVM.emotion, Emotion.Fine)
        }
      }
    }
}
