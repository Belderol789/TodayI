//
//  Months.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/22/24.
//

import Foundation

enum Month: String, CaseIterable {
  case January = "January"
  case February = "February"
  case March = "March"
  case April = "April"
  case May = "May"
  case June = "June"
  case July = "July"
  case August = "August"
  case September = "September"
  case October = "October"
  case November = "November"
  case December = "December"
  
  var number: Int {
    switch self {
    case .January: return 1
    case .February: return 2
    case .March: return 3
    case .April: return 4
    case .May: return 5
    case .June: return 6
    case .July: return 7
    case .August: return 8
    case .September: return 9
    case .October: return 10
    case .November: return 11
    case .December: return 12
    }
  }
}
