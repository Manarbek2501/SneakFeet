//
//  SneakFeetModal.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI

class StoreModal: ObservableObject {
    @Published var shoeSize: String = "41.5"
    @Published var shoeSizeText: String {
           didSet {
               UserDefaults.standard.set(shoeSizeText, forKey: "shoeSizeText")
           }
       }
       
       init() {
           self.shoeSizeText = UserDefaults.standard.object(forKey: "shoeSizeText") as? String ?? ""
       }
}
