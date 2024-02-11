//
//  CustomTabBarContainerView.swift
//  Buhatapp
//
//  Created by Kemuel Clyde Belderol on 12/4/23.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
  
  // ----------------------------------
  //  MARK: - Properties -
  //
  
  @Binding var showTabbar: Bool
  @Binding var selection: TabBarTypes
  let content: Content
  @State private var tabTypes: [TabBarTypes] = []
  
  // ----------------------------------
  //  MARK: - Init -
  //
  
  init(selection: Binding<TabBarTypes>, showTabbar: Binding<Bool>, @ViewBuilder content: () -> Content) {
    self._selection = selection
    self._showTabbar = showTabbar
    self.content = content()
  }
  
  // ----------------------------------
  //  MARK: - Body -
  //
  
  var body: some View {
    tabBarContainer
  }
}

// ----------------------------------
//  MARK: - Subviews -
//

extension CustomTabBarContainerView {
  private var tabBarContainer: some View {
    
    ZStack(alignment: .bottom) {
      content
      CustomTabbarView(tabs: tabTypes,
                       selection: $selection,
                       localSelection: selection)
      .opacity(showTabbar ? 1 : 0)
    }//: ZStack
    .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
      self.tabTypes = value
    })
  }
}
