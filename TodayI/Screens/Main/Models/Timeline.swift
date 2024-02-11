//
//  Timeline.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import Foundation

struct Timeline: Identifiable, Hashable {
  
  let calendar = Calendar.current
  var id: String {
    return title
  }
  let selectedYear: Int
  let type: TimelineTypes
  let title: String
  var dates: [String] = []
  
  var currentDate: Date {
    if type == .months {
      guard let month = Month(rawValue: title.lowercased()),
              let date = calendar.date(from: DateComponents(year: selectedYear, month: month.number)) else { return Date() }
      return date
    } else {
      guard let date = calendar.date(from: DateComponents(year: selectedYear)) else { return Date() }
      return date
    }
  }
  
  init(type: TimelineTypes, title: String, selectedYear: Int) {
    self.type = type
    self.title = title
    self.selectedYear = selectedYear
    self.dates = getAllTimelineDates()
  }
  
  func getAllTimelineDates() -> [String] {
    var allDays: [String] = []
    allDays = currentDate.allDays(in: type).compactMap({$0.toString()})
    return allDays
  }
}


enum TimelineTypes: String, CaseIterable, Identifiable {
  var id: String {
    self.rawValue
  }
  case year = "Year"
  case months = "Months"
}

