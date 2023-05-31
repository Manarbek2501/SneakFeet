//
//  CustomStepper.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 27.05.2023.
//

import Foundation
import SwiftUI

struct MyStepper: View {
    @Binding var stepperValue: Int
    @EnvironmentObject var storeModal: StoreModal
    
//    didTap: () -> Int
    
    var `in`: ClosedRange<Int> 

    var body: some View {
            HStack {
                Button("-") {
                    if stepperValue > 0 {
                        stepperValue -= 1
                        deleteStepperItems(item: stepperValue)
                    }
                }
                Spacer()
                Text(stepperValue.formatted())
                Spacer()
                Button("+") {
                    if stepperValue < 6 {
                        stepperValue += 1
                        addStepperItems(item: stepperValue)
                    }
                }
            }
            .padding(.horizontal, 32)
            .foregroundColor(.white)
            .buttonStyle(.plain)
            
    }
    
    func addStepperItems(item: Int) {
        storeModal.items.append(item)
        saveStepperItems(storeModal.items)
//        didTap?(item)
    }
    func saveStepperItems(_ item: [Int]) {
        let defaults = UserDefaults.standard
        defaults.set(storeModal.items, forKey: "stepperItems")
    }
    func deleteStepperItems(item: Int) {
        storeModal.items.removeLast()
        saveStepperItems(storeModal.items)
//        didTap?(item)
    }
}
