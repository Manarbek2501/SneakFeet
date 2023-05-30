//
//  CatalogModal.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 30.05.2023.
//

import Foundation

struct CatalogData: Identifiable, Equatable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var image: String
    var price: Int
}
