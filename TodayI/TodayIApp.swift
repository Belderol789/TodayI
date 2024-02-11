//
//  TodayIApp.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    
    return true
  }
}

@main
struct TodayIApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  let persistenceController = MemoryManager.shared
  
  var body: some Scene {
    WindowGroup {
      AppTabBarView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
