//
//  SneakFeetModal.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI

class StoreModal: ObservableObject {
    @Published var shoeSize: String = "41.5"
    @Published var cards = [Card]()
    @Published var items: [Card] = StoreCotolog.cards
    func add(item: Card) {
        cards.append(item)
    }
    
    func remove(item: Card) {
        if let index = cards.firstIndex(of: item) {
            cards.remove(at: index)
        }
    }
    
    @Published var shoeSizeText: String {
           didSet {
               UserDefaults.standard.set(shoeSizeText, forKey: "shoeSizeText")
           }
       }
       
       init() {
           self.shoeSizeText = UserDefaults.standard.object(forKey: "shoeSizeText") as? String ?? ""
       }
}
