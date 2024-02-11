//
//  TabBarType.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import SwiftUI

// ----------------------------------
//  MARK: - TabBarTypes -
//

enum TabBarTypes: CaseIterable, Hashable {
  case home
  case create
  case profile
  case random
  
  var item: TabBarItem {
    switch self {
    case .home:
      return TabBarItem(defaultIconName: "face.dashed")
    case .create:
      return TabBarItem(defaultIconName: "calendar.badge.plus")
    case .random:
      return TabBarItem(defaultIconName: "clock.badge.questionmark.fill")
    case .profile:
      return TabBarItem(defaultIconName: "person")
    }
  }
}

// ----------------------------------
//  MARK: - TabBarItem -
//

struct TabBarItem: Hashable {
  let defaultIconName: String
  var title: String = ""
  var color: Color = Color.primary
}

