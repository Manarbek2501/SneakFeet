//
//  HistoryModel.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 01.06.2023.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct HistoryModel: Identifiable, Equatable, Codable, Hashable{
    var id = UUID()
    let order: String
    let orderedImage: [String]
    let creationDate: String
    let items: String
    let price: String
    
    let title: [String]
    let description: [String]
    let item: [String]
    let prices: [Int]
    
    init(order: String, orderedImage: [String], creationDate: String, items: String, price: String, title: [String], description: [String], item: [String], prices: [Int]) {
        self.order = order
        self.orderedImage = orderedImage
        self.creationDate = creationDate
        self.items = items
        self.price = price
        self.title = title
        self.description = description
        self.item = item
        self.prices = prices
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        order = try container.decode(String.self, forKey: .order)
        orderedImage = try container.decode([String].self, forKey: .orderedImage)
        creationDate = try container.decode(String.self, forKey: .creationDate)
        items = try container.decode(String.self, forKey: .items)
        price = try container.decode(String.self, forKey: .price)
        title = try container.decode([String].self, forKey: .title)
        description = try container.decode([String].self, forKey: .description)
        item = try container.decode([String].self, forKey: .item)
        prices = try container.decode([Int].self, forKey: .prices)
    }
    
    enum CodingKeys: String, CodingKey {
        case order
        case orderedImage
        case creationDate
        case items
        case price
        case title
        case description
        case item
        case prices
    }
}
