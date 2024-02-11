//
//  Emotion.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import SwiftUI

enum Emotion: Int, CaseIterable {
  case Angry
  case Disgust
  case Happy
  case Sad
  case Worried
  case Fine
  
  var name: String {
    switch self {
    case .Angry:
      return "Angry"
    case .Disgust:
      return "Disgusted/Sick"
    case .Happy:
      return "Happy"
    case .Sad:
      return "Sad"
    case .Worried:
      return "Worried"
    case .Fine:
      return "Fine"
    }
  }
  
  
  var image: ImageResource {
    switch self {
    case .Angry:
      return .angry
    case .Disgust:
      return .disgusted
    case .Happy:
      return .happy
    case .Sad:
      return .sad
    case .Worried:
      return .scared
    case .Fine:
      return .neutral
    }
  }
  
  var color: Color {
    switch self {
    case .Angry:
      return .red
    case .Disgust:
      return .green
    case .Happy:
      return .yellow
    case .Sad:
      return .blue
    case .Worried:
      return .purple
    case .Fine:
      return .mint
    }
  }
}

