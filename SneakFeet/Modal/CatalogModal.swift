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
    var item: Int
    var clicked: Bool
}
extension CatalogData {
    func toCartModel() -> CartModel {
        return CartModel(
            title: self.title,
            image: self.image,
            description: self.description,
            price: String(self.price),
            item: "1",
            clicked: self.clicked
        )
    }
}
