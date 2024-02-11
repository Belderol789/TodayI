//
//  MainViewModel.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/26/24.
//

import SwiftUI
import CoreData

class MainViewModel: ObservableObject {
  
  @Published var memories: [Memory] = []
  @Published var timelineTypes: [TimelineTypes] = TimelineTypes.allCases
  @Published var selectedTimeline: TimelineTypes = .year
  @Published var selectedYear: Int = Date().year
  @Published var timeLines: [TimelineTypes: [Timeline]] = [:]
  
  var selectedTimelines: [Timeline] {
    return timeLines[selectedTimeline] ?? []
  }

  func updateTimelines() {
    timeLines[.year] = [Timeline(type: .year, title: "\(selectedYear)", selectedYear: selectedYear)]
    let months = Month.allCases.compactMap({
      Timeline(type: .months, title: $0.rawValue.capitalized, selectedYear: selectedYear)
    })
    timeLines[.months] = months
  }
  
  func getAllMemories(allMemories: FetchedResults<Memory>, viewContext: NSManagedObjectContext) {
    if allMemories.filter({$0.year == selectedYear}).isEmpty {
      FirebaseManager.shared.getAllMemories(for: selectedYear) { documentData in
        for data in documentData {
          let newMemory = Memory(context: viewContext)
          newMemory.dateString = data["dateString"] as? String
          newMemory.emotionInt = (data["emotion"] as? Int16)!
          newMemory.id = data["userID"] as? String
          newMemory.journalEntry = data["journalEntry"] as? String
          newMemory.media = data["media"] as? [String]
        }
        MemoryManager.shared.save()
      }
    } else {
      loadLocalMemories(allMemories)
    }
  }
  
  func loadLocalMemories(_ allMemories: FetchedResults<Memory>) {
    memories = Array(allMemories)
  }
  
}
