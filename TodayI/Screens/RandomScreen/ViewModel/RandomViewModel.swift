//
//  RandomViewModel.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 2/11/24.
//


import SwiftUI

class RandomViewModel: ObservableObject {
  
  // ----------------------------------
  //  MARK: - Properties -
  //
  
  @Published var randomMemory: Memory?
  @Published var selectedEmotion: String = "All"
  @Published var emptyText = ""
  
  // ----------------------------------
  //  MARK: - Computed -
  //
  
  var emotionNames: [String] {
    var emotions = Emotion.allCases.compactMap({$0.name})
    emotions.append("All")
    return emotions
  }
  
  var emotionColor: Color {
    return randomMemory?.emotion.color ?? .clear
  }
  
  var selectedColor: Color {
    return selectedEmotion == "All" ? Color.primary : Emotion.allCases.filter({$0.name == selectedEmotion}).first!.color
  }
  
  
}
