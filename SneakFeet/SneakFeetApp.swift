//
//  SneakFeetApp.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI
import FirebaseCore


// Krasapet
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct SneakFeetApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var storeModal: StoreModal = .init()
    @StateObject var viewModal = AuthViewModal()
    @StateObject var catalogModal: CatalogModalData = .init()
    @StateObject var cartModel: CartModalData = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storeModal)
                .environmentObject(viewModal)
                .environmentObject(catalogModal)
                .environmentObject(cartModel)
        }
    }
}

