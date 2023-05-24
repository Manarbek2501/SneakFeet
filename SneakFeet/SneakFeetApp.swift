//
//  SneakFeetApp.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI

@main
struct SneakFeetApp: App {
    @StateObject var storeModal: StoreModal = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storeModal)
        }
    }
}
