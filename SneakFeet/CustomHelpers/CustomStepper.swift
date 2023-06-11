//
//  CustomStepper.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 27.05.2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

struct CustomStepper: View {
    @EnvironmentObject var storeModal: StoreModal
    @EnvironmentObject var cartModel: CartModalData
    let stepperValue: Int
    let index: Int
    var body: some View {
        HStack {
            Button("-") {
                if stepperValue > 0 {
                    cartModel.stepper -= 1
                    cartModel.updateStepperValues(newValue: cartModel.stepper, stepper: cartModel.stepper, atIndex: index)
                }
            }
            Spacer()
            Text("\(stepperValue)")
            Spacer()
            Button("+") {
                if stepperValue < 6 {
                    cartModel.stepper += 1
                    cartModel.updateStepperValues(newValue: cartModel.stepper, stepper: cartModel.stepper, atIndex: index)
                }
            }
        }
        .padding(.horizontal, 32)
        .foregroundColor(.white)
        .buttonStyle(.plain)
    }
}


