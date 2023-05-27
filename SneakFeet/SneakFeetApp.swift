//
//  SneakFeetApp.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI
import FirebaseCore

//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//    return true
//  }
//}

@main
struct SneakFeetApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init() {
        FirebaseApp.configure()
    }
    @StateObject var storeModal: StoreModal = .init()
    @StateObject var viewModal = AuthViewModal()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storeModal)
                .environmentObject(viewModal)
        }
    }
}

//struct YourApp: App {
//  // register app delegate for Firebase setup
//
//
//  var body: some Scene {
//    WindowGroup {
//      NavigationView {
//        ContentView()
//      }
//    }
//  }
//}
