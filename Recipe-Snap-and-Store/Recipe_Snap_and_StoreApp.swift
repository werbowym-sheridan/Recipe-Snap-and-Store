//
//  Recipe_Snap_and_StoreApp.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
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
struct Recipe_Snap_and_StoreApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var authService = AuthenticationService.shared
  @StateObject var recipeVM = RecipeViewModel()


  var body: some Scene {
    WindowGroup {
        if authService.user != nil {
            MainView()
                .environmentObject(authService)
                .environmentObject(recipeVM)
        } else {
            ContentView()
                .environmentObject(authService)
        }
    }
  }
}
