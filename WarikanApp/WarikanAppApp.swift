//
//  WarikanAppApp.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/08.
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
struct WarikanAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
