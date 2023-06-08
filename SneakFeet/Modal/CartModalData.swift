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
    @Published var stepper: Int = 1
    
    let currentUserID: String
    
    init() {
        currentUserID = Auth.auth().currentUser?.uid ?? ""
        
        Task {
            await fetchCartForCurrentUserFirestore()
        }
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
            let documentRef = userCartCollection.document()
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
                    self.stepper = cartItem.stepperValues
                } catch {
                    print("Failed to decode cart item: \(error)")
                }
            }
            
            completion(cartData)
        }
    }
    
    func fetchCartForCurrentUserFirestore() async {
        if let userID = getCurrentUserID() {
            fetchFromFirestoreData(userID: userID) { cart in
                self.cartValue = cart
            }
        } else {
            print("User is not authenticated.")
        }
    }
    
    func deleteFromCart(indices: IndexSet) {
        let itemsToDelete = indices.map { cartValue[$0] }
        for (index, item) in itemsToDelete.enumerated() {
            guard let documentID = item.id else { continue }
            guard let userID = Auth.auth().currentUser?.uid else { return }
            let documentRef = Firestore.firestore()
                .collection("carts")
                .document(userID)
                .collection("cartItems")

            documentRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    return
                }

                let selectedDocument = documents[index]
                let selectedDocumentID = selectedDocument.documentID
                documentRef.document(selectedDocumentID).delete()
            }
        }
        cartValue.remove(atOffsets: indices)
    }
    
    func updateStepperValues(newValue: Int, stepper: Int) {
        let itemsToDelete = cartValue
        for (index, item) in itemsToDelete.enumerated() {
            guard item.id != nil else { continue }
            guard let userID = Auth.auth().currentUser?.uid else { return }
            let documentRef = Firestore.firestore()
                .collection("carts")
                .document(userID)
                .collection("cartItems")
            documentRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    return
                }

                let selectedDocument = documents[index]
                let selectedDocumentID = selectedDocument.documentID

                documentRef.document(selectedDocumentID).updateData(["stepperValues": newValue]) { error in
                    if let error = error {
                        // Handle any error that occurred during the update
                        print("Error updating stepper value: \(error.localizedDescription)")
                    } else {
                        // Update successful
                        print("Stepper value updated successfully!")
                    }
                }
                documentRef.document(selectedDocumentID).updateData(["stepper": stepper]) { error in
                    if let error = error {
                        // Handle any error that occurred during the update
                        print("Error updating stepper value: \(error.localizedDescription)")
                    } else {
                        // Update successful
                        print("Stepper value updated successfully!")
                    }
                }
            }
        }
    }
    
    func fetchData() async {
        await fetchCartForCurrentUserFirestore()
    }
}
