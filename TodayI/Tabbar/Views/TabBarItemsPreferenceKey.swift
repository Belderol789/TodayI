//
//  TabBarItemsPreferenceKey.swift
//  Buhatapp
//
//  Created by Kemuel Clyde Belderol on 12/4/23.
//

import Foundation
import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey {
  
  static let defaultValue: [TabBarTypes] = []
  
  static func reduce(value: inout [TabBarTypes], nextValue: () -> [TabBarTypes]) {
    value += nextValue()
  }
  
}

struct TabBarItemViewModifier: ViewModifier {
  
  let tab: TabBarTypes
  @Binding var selection: TabBarTypes
  
  func body(content: Content) -> some View {
    return content
      .opacity(selection == tab ? 1.0 : 0.0)
      .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
  }
  
}

extension View {
  func tabBarItem(_ tab: TabBarTypes, selection: Binding<TabBarTypes>) -> some View {
    return modifier(TabBarItemViewModifier(tab: tab, selection: selection))
  }
}
