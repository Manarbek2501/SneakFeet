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
}
