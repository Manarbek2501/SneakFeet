//
//  CatalogModalData.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 30.05.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseDatabase


@MainActor
class CatalogModalData: ObservableObject {
    
    @Published var catalogData = [CatalogData]()
    @Published var orderHistoryValue: [HistoryModel] = []
    
    init() {
        let db = Firestore.firestore()
        
        db.collection("catalogView").getDocuments { (snap, error) in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            for catalogCards in snap!.documents {
                _ = catalogCards.documentID
                let title = catalogCards.get("title") as! String
                let description = catalogCards.get("description") as? String
                let image = catalogCards.get("image") as! String
                let price = catalogCards.get("price") as! Int
                
                self.catalogData.append(CatalogData(title: title, description: description ?? "Description", image: image, price: price, item: 1, clicked: false))
                
            }
            
        }
        Task {
            await fetchOrderData()
        }
    }
    
    func saveOrderHistoryForUser(userID: String, order: String, orderedImage: [String], creationDate: String, items: String, price: String, title: [String], description: [String], item: [String], prices: [Int]) {
        let historyItem = HistoryModel(order: order, orderedImage: orderedImage, creationDate: creationDate, items: items, price: price, title: title, description: description, item: item, prices: prices)
        
        let ref = Database.database().reference()
        
        let userHistoryRef = ref.child("orderHistory").child(userID).childByAutoId()
        
        let historyDict: [String: Any] = [
            "order": historyItem.order,
            "orderedImage": historyItem.orderedImage,
            "creationDate": historyItem.creationDate,
            "items": historyItem.items,
            "price": historyItem.price,
            "title": historyItem.title,
            "description": historyItem.description,
            "item": historyItem.item,
            "prices": historyItem.prices
        ]
        
        userHistoryRef.setValue(historyDict) { error, _ in
            if let error = error {
                print("Failed to save order history: \(error)")
            } else {
                print("Order history saved successfully")
            }
        }
    }
    func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func saveOrderHistoryForCurrentUser(order: String, orderedImage: [String], creationDate: String, items: String, price: String, title: [String], description: [String], item: [String], prices: [Int]) {
        if let userID = getCurrentUserID() {
            saveOrderHistoryForUser(userID: userID, order: order, orderedImage: orderedImage, creationDate: creationDate, items: items, price: price, title: title, description: description, item: item, prices: prices)
        } else {
            print("User is not authenticated.")
        }
    }
    
    func fetchOrderHistoryForUser(userID: String, completion: @escaping ([HistoryModel]) -> Void) {
        let ref = Database.database().reference().child("orderHistory").child(userID)
        
        ref.observeSingleEvent(of: .value) { snapshot in
            var orderHistory: [HistoryModel] = []
            
            for childSnapshot in snapshot.children {
                if let childSnapshot = childSnapshot as? DataSnapshot,
                   let historyDict = childSnapshot.value as? [String: Any] {
                    
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: historyDict, options: [])
                        let historyItem = try JSONDecoder().decode(HistoryModel.self, from: jsonData)
                        
                        orderHistory.append(historyItem)
                    } catch {
                        print("Failed to decode order history: \(error)")
                    }
                }
            }
            completion(orderHistory)
        }
    }
    
    func fetchOrderHistoryForCurrentUser() async {
        if let userID = getCurrentUserID() {
            fetchOrderHistoryForUser(userID: userID) { history in
                self.orderHistoryValue = history
            }
        } else {
            print("User is not authenticated.")
        }
    }
    
    func fetchOrderData() async {
        await fetchOrderHistoryForCurrentUser()
    }
}
