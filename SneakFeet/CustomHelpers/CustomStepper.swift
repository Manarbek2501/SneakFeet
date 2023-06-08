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

struct MyStepper: View {
    @EnvironmentObject var storeModal: StoreModal
    @EnvironmentObject var cartModel: CartModalData
    var body: some View {
        VStack {
            ForEach(cartModel.cartValue) { cartItem in
                HStack {
                    Button("-") {
                        if cartItem.stepperValues > 0 {
                            cartModel.stepper -= 1
                            cartModel.updateStepperValues(newValue: cartModel.stepper, stepper: cartModel.stepper)
                        }
                    }
                    Spacer()
                    Text("\(cartItem.stepperValues)")
                    Spacer()
                    Button("+") {
                        if cartItem.stepperValues < 6 {
                            cartModel.stepper += 1
                            cartModel.updateStepperValues(newValue: cartModel.stepper, stepper: cartModel.stepper)
                        }
                    }
                }
                .onAppear {
                    Task {
                        await cartModel.fetchData()
                    }
                }
                .padding(.horizontal, 32)
                .foregroundColor(.white)
                .buttonStyle(.plain)
            }
        }
    }
}


