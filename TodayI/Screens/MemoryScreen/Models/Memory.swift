//
//  Memory.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import Foundation

/// NOTE: - Memory is a CoreData Object
extension Memory {
  
  var emotion: Emotion {
    return Emotion(rawValue: Int(self.emotionInt)) ?? .Fine
  }
  
  var date: String {
    return dateString ?? "0/0/0"
  }
  
  var day: Int {
    return Int(date.components(separatedBy: "/")[0]) ?? 0
  }
  
  var month: Int {
    return Int(date.components(separatedBy: "/")[1]) ?? 0
  }
  
  var year: Int {
    return Int("20" + date.components(separatedBy: "/")[2]) ?? 0
  }
  
}
