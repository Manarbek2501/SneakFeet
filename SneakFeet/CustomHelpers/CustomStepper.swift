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
    var `in`: ClosedRange<Int> 

    var body: some View {
            HStack {
                Button("-") {
                    if stepperValue > 1 {
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
            .padding(.horizontal, 32)
            .foregroundColor(.white)
            .buttonStyle(.plain)
    }
}
