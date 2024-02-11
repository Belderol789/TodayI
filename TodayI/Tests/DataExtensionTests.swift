//
//  DataExtensionTests.swift
//  TodayITests
//
//  Created by Kemuel Clyde Belderol on 2/11/24.
//

@testable import TodayI
import XCTest

class DateExtensionTests: XCTestCase {
  
  func testToString() {
    // Given
    let date = Calendar.current.date(from: DateComponents(year: 2018, month: 1, day: 15))
    
    // When
    let dateString = date?.toString()
    
    // Then
    XCTAssertNotNil(dateString)
    XCTAssertEqual(dateString, "1/15/18")
  }
  
  func testToStringWithFormat() {
    // Given
    let date = Calendar.current.date(from: DateComponents(year: 2018, month: 1, day: 15))
    let format = "yyyy-MM-dd"
    
    // When
    let dateString = date?.toStringWith(format: format)
    
    // Then
    XCTAssertNotNil(dateString)
    XCTAssertEqual("2018-01-15", dateString)
  }
  
  func testYear() {
    // Given
    let date = Calendar.current.date(from: DateComponents(year: 2018, month: 1, day: 15))
    
    // When
    let year = date?.year
    
    // Then
    XCTAssertNotNil(year)
    XCTAssertEqual(year, 2018)
  }
  
  func testAddingDays() {
    // Given
    let date = Calendar.current.date(from: DateComponents(year: 2018, month: 1, day: 15))
    let daysToAdd = 5
    
    // When
    let newDate = date?.addingDays(daysToAdd)
    
    // Then
    XCTAssertNotNil(newDate)
    XCTAssertEqual(newDate, Calendar.current.date(from: DateComponents(year: 2018, month: 1, day: 20)))
  }
  
  func testFirstDayOfTheMonth() {
    // Given
    let date = Date()
    
    // When
    let firstDay = date.firstDayOfTheMonth()
    
    // Then
    XCTAssertNotNil(firstDay)
  }
  
  func testAllDays() {
    // Given
    let date = Date()
    let type: TimelineTypes = .months // Assuming `TimelineTypes` is an enum defined elsewhere
    
    // When
    let allDays = date.allDays(in: type)
    
    // Then
    XCTAssertNotNil(allDays)
  }
}
