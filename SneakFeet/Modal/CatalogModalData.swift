//
//  CatalogModalData.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 30.05.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift



@MainActor
class CatalogModalData: ObservableObject {
    
    @Published var catalogData = [CatalogData]()
    @Published var orderHistory = [HistoryModel]()
    @Published var savedOrder = [HistoryModel]()
    
    func saveOrderHistory(order: String, orderedImage: [String], creationDate: String, items: String, price: String, title: [String], description: [String], item: [String], prices: [Int]) {
            let historyItem = HistoryModel(order: order, orderedImage: orderedImage, creationDate: creationDate, items: items, price: price, title: title, description: description, item: item, prices: prices)
        addOrder(item: historyItem)
        orderHistory.append(historyItem)
        }
    
    func addOrder(item: HistoryModel) {
        var order = retrieveOrder()
        order.append(item)
        saveOrder(order)
    }
    func saveOrder(_ cards: [HistoryModel]) {
        do {
            let encoder = JSONEncoder()
            let encodedCards = try encoder.encode(cards)
            UserDefaults.standard.set(encodedCards, forKey: "orderValues")
        } catch {
            print("Ошибка при кодировании cards: \(error)")
        }
    }
    func retrieveOrder() -> [HistoryModel] {
        if let encodedCards = UserDefaults.standard.data(forKey: "orderValues") {
            do {
                let decoder = JSONDecoder()
                let decodedCards = try decoder.decode([HistoryModel].self, from: encodedCards)
                return decodedCards
            } catch {
                // Handle decoding error if necessary
                print("Error decoding cards: \(error)")
            }
        }
        return []
    }
    
    init() {
        let db = Firestore.firestore()
        
        db.collection("catalogView").getDocuments { (snap, error) in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            for catalogCards in snap!.documents {
                let id = catalogCards.documentID
                let title = catalogCards.get("title") as! String
                let description = catalogCards.get("description") as? String
                let image = catalogCards.get("image") as! String
                let price = catalogCards.get("price") as! Int
                
                self.catalogData.append(CatalogData(title: title, description: description ?? "description", image: image, price: price))
                
            }
            
        }
    }
}
