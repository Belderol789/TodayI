//
//  AppTabBarView.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import SwiftUI

struct AppTabBarView: View {
  
  // ----------------------------------
  //  MARK: - Properties -
  //
  
  @State private var selection: TabBarTypes = .home
  @State var showTabbar: Bool = true
  
  // ----------------------------------
  //  MARK: - Body -
  //
  
  var body: some View {
    CustomTabBarContainerView(selection: $selection, showTabbar: $showTabbar) {
      MainView(showTabbar: $showTabbar)
        .tabBarItem(.home, selection: $selection)
      CreateView(showTabbar: $showTabbar)
        .tabBarItem(.create, selection: $selection)
      RandomView(showTabbar: $showTabbar)
        .tabBarItem(.random, selection: $selection)
    }
    .ignoresSafeArea(.keyboard)
  }
}

#Preview {
  AppTabBarView()
}

