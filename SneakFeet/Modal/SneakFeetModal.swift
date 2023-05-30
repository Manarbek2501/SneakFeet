//
//  SneakFeetModal.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI

class StoreModal: ObservableObject {
    @Published var cards = [CatalogData]()
    @Published var items = [CatalogData].self
    
//    func add(item: CatalogData) {
//        cards.append(item)
//        UserDefaults.standard.set(cards, forKey: "catalogInList")
//    }
    
    func add(item: CatalogData) {
        var cards = retrieveCards()
        cards.append(item)
        saveCards(cards)
    }

    func saveCards(_ cards: [CatalogData]) {
        do {
            let encoder = JSONEncoder()
            let encodedCards = try encoder.encode(cards)
            UserDefaults.standard.set(encodedCards, forKey: "catalogInList")
        } catch {
            print("Ошибка при кодировании cards: \(error)")
        }
    }
    
    func retrieveCards() -> [CatalogData] {
        if let encodedCards = UserDefaults.standard.data(forKey: "catalogInList") {
            do {
                let decoder = JSONDecoder()
                let decodedCards = try decoder.decode([CatalogData].self, from: encodedCards)
                return decodedCards
            } catch {
                // Handle decoding error if necessary
                print("Error decoding cards: \(error)")
            }
        }
        return []
    }
    
    func remove(item: CatalogData) {
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

