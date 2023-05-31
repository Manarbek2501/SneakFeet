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
