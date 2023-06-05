//
//  CartModalData.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 04.06.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseDatabase

class CartModalData: ObservableObject {
    
    @Published var cartValue = [CartModel]()
    
    let currentUserID: String
    
    init() {
        currentUserID = Auth.auth().currentUser?.uid ?? ""
    }
    
    func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }

    func saveToFirestore(cartModel: CartModel) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }
        
        let db = Firestore.firestore()
        let userCartCollection = db.collection("carts").document(userID).collection("cartItems")
        
        do {
            let data = try JSONEncoder().encode(cartModel)
            let documentRef = userCartCollection.document() // Automatically generates a unique document ID
            try documentRef.setData(from: cartModel)
        } catch {
            print("Error encoding cart model: \(error)")
        }
    }
    

    func fetchFromFirestoreData(userID: String, completion: @escaping ([CartModel]) -> Void) {
        let db = Firestore.firestore()
        let userCartCollection = db.collection("carts").document(userID).collection("cartItems")
        
        userCartCollection.getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion([])
                return
            }
            
            var cartData: [CartModel] = []
            
            for document in querySnapshot?.documents ?? [] {
                do {
                    let cartItem = try document.data(as: CartModel.self)
                    cartData.append(cartItem)
                } catch {
                    print("Failed to decode cart item: \(error)")
                }
            }
            
            completion(cartData)
        }
    }

    func fetchCartForCurrentUserFirestore() {
        if let userID = getCurrentUserID() {
            fetchFromFirestoreData(userID: userID) { cart in
                self.cartValue = cart
            }
        } else {
            print("User is not authenticated.")
        }
    }


}
