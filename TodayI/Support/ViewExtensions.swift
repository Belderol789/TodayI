//
//  ViewExtensions.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/23/24.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
#endif
