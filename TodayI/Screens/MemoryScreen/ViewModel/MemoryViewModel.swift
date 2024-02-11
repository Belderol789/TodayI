//
//  MemoryViewModel.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import SwiftUI

class MemoryGridViewModel: ObservableObject {
  
  @Published var selectedMemory: Memory = Memory()
  @Published var timeLine: Timeline = .init(type: .year, title: "", selectedYear: Date().year)
  @Published var geometryWidth: CGFloat = 0
  @Published var selectedDate: String = ""
  @Published var goToCreate: Bool = false
  @Published var showDetail: Bool = false
  
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  init(geometry: CGFloat, timeline: Timeline) {
    self.geometryWidth = geometry
    self.timeLine = timeline
  }
  
  var itemWidth: CGFloat {
    return (geometryWidth / CGFloat(columns.count)) - 12
  }
  
  func getMemory(memories: [Memory], for date: String) -> Memory? {
    guard let memory = memories.filter({$0.dateString == date}).first else { return nil }
    return memory
  }
}


