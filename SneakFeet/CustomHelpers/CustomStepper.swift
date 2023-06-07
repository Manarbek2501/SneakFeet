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
    
    @Binding var stepperValue: Int
    @EnvironmentObject var storeModal: StoreModal
    @EnvironmentObject var cartModel: CartModalData
    var body: some View {
        HStack {
            Button("-") {
                if stepperValue > 0 {
                    stepperValue -= 1
                    
                }
            }
            Spacer()
            Text(stepperValue.formatted())
            Spacer()
            Button("+") {
                if stepperValue < 6 {
                    stepperValue += 1
                    
                }
            }
        }
        .onAppear {
            
        }
        .padding(.horizontal, 32)
        .foregroundColor(.white)
        .buttonStyle(.plain)
    }
}
