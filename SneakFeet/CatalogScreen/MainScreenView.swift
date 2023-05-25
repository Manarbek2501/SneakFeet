//
//  MainScreenView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI

struct MainScreenView: View {
    var body: some View {
        TabView {
            CatalogScreenView()
                .tabItem {
                    Label("Catalog", systemImage: "house.fill")
                }
            CartListScreenView()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill.badge.plus")
                }
            ProfileScreenView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
        }
        .tint(Color.black)
    }
}

extension UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        
        self.tabBar.standardAppearance = appearance
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
