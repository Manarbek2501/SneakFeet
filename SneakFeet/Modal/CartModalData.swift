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
    @Published var documnetID: String = ""
    var selectedID: String?
    
    let currentUserID: String
    
    init() {
        currentUserID = Auth.auth().currentUser?.uid ?? ""
        
        Task {
            await fetchData()
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
            var updatedCartModel = cartModel // Create a mutable copy of the cart model
            let documentRef = userCartCollection.document()
            updatedCartModel.id = documentRef.documentID // Assign the document ID to the `id` property
            
            try documentRef.setData(from: updatedCartModel) // Save the updated cart model with the document ID
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
    
    func fetchCartForCurrentUserFirestore() {
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
                documentRef.document(selectedDocumentID).delete()
            }
        }
        cartValue.remove(atOffsets: indices)
    }
    
    
    func updateStepperValues(newValue: Int, stepper: Int, atIndex index: Int) {
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
            
            documentRef.document(selectedDocumentID).updateData(["stepperValues": newValue, "stepper": stepper]) { error in
                if let error = error {
                    print("Error updating stepper value: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchData() async {
        fetchCartForCurrentUserFirestore()
    }
}
