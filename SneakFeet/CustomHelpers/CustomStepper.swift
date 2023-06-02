//
//  CustomStepper.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 27.05.2023.
//

import Foundation
import SwiftUI

struct MyStepper: View {
    
    @State private var stepperValue: Int = 1
    @EnvironmentObject var storeModal: StoreModal
    
    var body: some View {
        HStack {
            Button("-") {
                if stepperValue > 0 {
                    stepperValue -= 1
                    storeModal.deleteStepperItems(item: stepperValue)
                }
            }
            Spacer()
            Text(stepperValue.formatted())
            Spacer()
            Button("+") {
                if stepperValue < 6 {
                    stepperValue += 1
                    storeModal.addStepperItems(item: stepperValue)
                }
            }
        }
        .padding(.horizontal, 32)
        .foregroundColor(.white)
        .buttonStyle(.plain)
    }
}
