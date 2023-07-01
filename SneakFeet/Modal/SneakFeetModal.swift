//
//  SneakFeetModal.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI
import Firebase
import FirebaseDatabase

class StoreModal: ObservableObject { // It's model bro haha
    @Published var cards = [CatalogData]()
    @Published var items = [Int]()
    @Published var cardsWithCount = [UUID : Int]()
    
    
    func addStepperItems(item: Int) {
        items.append(item)
        saveStepperItems(items)
    }
    func saveStepperItems(_ item: [Int]) { // try to leave space between your functions :)
        let defaults = UserDefaults.standard
        defaults.set(items, forKey: "stepperItems")
    }
    func deleteStepperItems(item: Int) {// what do we do with item here ?
        if !items.isEmpty{
            items.removeLast()
        }
        saveStepperItems(items)
    }
    
    @Published var shoeSizeText: String {
        didSet {
            UserDefaults.standard.set(shoeSizeText, forKey: "shoeSizeText")
        }
    }
    
    init() {
        self.shoeSizeText = UserDefaults.standard.object(forKey: "shoeSizeText") as? String ?? ""
        self.items = UserDefaults.standard.object(forKey: "stepperItems") as? [Int] ?? []
    }
}

