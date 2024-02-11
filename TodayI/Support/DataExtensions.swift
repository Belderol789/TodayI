//
//  DataExtensions.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import SwiftUI

// ----------------------------------
//  MARK: - Color -
//

extension Color {
  static var random: Color {
    let colors = Emotion.allCases.compactMap({$0.color})
    return colors[Int.random(in: 0..<colors.count)]
  }
}


// ----------------------------------
//  MARK: - String -
//

extension String {
  
  func toDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yy"
    return dateFormatter.date(from: self)
  }
}



// ----------------------------------
//  MARK: - Date -
//

extension Date {
  
  func toString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    return dateFormatter.string(from: self)
  }
  
  func toStringWith(format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
  
  var year: Int {
    return Calendar.current.component(.year, from: self)
  }
  
  func addingDays(_ days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
  }
  
  func firstDayOfTheMonth() -> Date {
    return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self)) ?? self
  }
  
  func allDays(in type: TimelineTypes) -> [Date] {
    var days = [Date]()
    let calendar = Calendar.current
    let range = calendar.range(of: .day, in: type == .months ? .month : .year, for: self)!
    var day = firstDayOfTheMonth()
    for _ in 1...range.count {
      days.append(day)
      day = calendar.date(byAdding: .day, value: 1, to: day) ?? day
    }
    return days
  }
}


// ----------------------------------
//  MARK: - Calendar -
//

extension Calendar {
  static let iso8601 = Calendar(identifier: .iso8601)
}
