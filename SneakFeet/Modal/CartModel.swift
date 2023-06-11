//
//  CartModel.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 04.06.2023.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseDatabase
import FirebaseFirestoreSwift

struct CartModel: Identifiable, Equatable, Codable, Hashable{
    var id: String? = UUID().uuidString
    let title: String
    let image: String
    let description: String
    let price: String
    let item: String
    let clicked: Bool
    let stepperValues: Int
    let stepper: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, description, price, item, clicked, stepperValues, stepper
    }
    init(title: String, image: String, description: String, price: String, item: String, clicked: Bool, stepperValues: Int, stepper: Int) {
        self.title = title
        self.image = image
        self.description = description
        self.price = price
        self.item = item
        self.clicked = clicked
        self.stepperValues = stepperValues
        self.stepper = stepper
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.image = try container.decode(String.self, forKey: .image)
        self.description = try container.decode(String.self, forKey: .description)
        self.price = try container.decode(String.self, forKey: .price)
        self.item = try container.decode(String.self, forKey: .item)
        self.clicked = try container.decode(Bool.self, forKey: .clicked)
        self.stepperValues = try container.decode(Int.self, forKey: .stepperValues)
        self.stepper = try container.decode(Int.self, forKey: .stepper)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(image, forKey: .image)
        try container.encode(description, forKey: .description)
        try container.encode(price, forKey: .price)
        try container.encode(item, forKey: .item)
        try container.encode(clicked, forKey: .clicked)
        try container.encode(stepperValues, forKey: .stepperValues)
        try container.encode(stepper, forKey: .stepper)
    }
}

