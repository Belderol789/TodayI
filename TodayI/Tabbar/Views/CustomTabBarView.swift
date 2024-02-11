//
//  CustomTabbarView.swift
//  Buhatapp
//
//  Created by Kemuel Clyde Belderol on 12/4/23.
//

import SwiftUI

struct CustomTabbarView: View {
  
  // ----------------------------------
  //  MARK: - Properties -
  //
  
  let tabs: [TabBarTypes]
  @Binding var selection: TabBarTypes
  @Namespace private var namespace
  @State var localSelection: TabBarTypes
  
  // ----------------------------------
  //  MARK: - Body -
  //
  
  var body: some View {
    tabBarView
      .onChange(of: selection) { oldValue, newValue in
        withAnimation(.easeInOut) {
          localSelection = newValue
        }
      }
  }
}

// ----------------------------------
//  MARK: - Subviews -
//

extension CustomTabbarView {
  private var tabBarView: some View {
    HStack {
      ForEach(tabs, id: \.self) { tab in
        tabBarView(type: tab)
          .onTapGesture {
            switchToTab(tab: tab)
          }
      }
    }//: HStack
    .padding(6)
    .background(Color(UIColor.secondarySystemFill))
    .clipShape(RoundedRectangle(cornerRadius: 10))
    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    .padding(.horizontal)
  }
}


// ----------------------------------
//  MARK: - Methods -
//

extension CustomTabbarView {
  
  private func tabBarView(type: TabBarTypes) -> some View {
    VStack {
      Image(systemName: type.item.defaultIconName)
        .font(.subheadline)
    }//: VStack
    .foregroundStyle(type.item.color)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity)
    .background(
      ZStack {
        if localSelection == type {
          RoundedRectangle(cornerRadius: 10)
            .fill(Color(UIColor.secondarySystemBackground))
            .matchedGeometryEffect(id:  "background_rectangle", in: namespace)
        }
      }
    )
  }
  
  private func switchToTab(tab: TabBarTypes) {
    withAnimation(.easeInOut) {
      selection = tab
    }
  }
}

// ----------------------------------
//  MARK: - Preview -
//

#Preview {
  
  let testTabs = TabBarTypes.allCases
  
  return VStack {
    Spacer()
    CustomTabbarView(tabs: testTabs,
                     selection: .constant(testTabs.first!),
                     localSelection: testTabs.first!)
  }
}
