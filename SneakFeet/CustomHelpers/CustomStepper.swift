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
    @EnvironmentObject var catalogModel: CatalogModalData
    var body: some View {
        HStack {
            Button("-") {
                if stepperValue > 0 {
                    stepperValue -= 1
                    saveStepperValueToFirestore()
                }
            }
            Spacer()
            Text(stepperValue.formatted())
            Spacer()
            Button("+") {
                if stepperValue < 6 {
                    stepperValue += 1
                    saveStepperValueToFirestore()
                }
            }
        }
        .onAppear {
            fetchStepperValueFromFirestore()
        }
        .padding(.horizontal, 32)
        .foregroundColor(.white)
        .buttonStyle(.plain)
    }
    
    func saveStepperValueToFirestore() {
        let docRef = Firestore.firestore().collection("stepperValue").document(Auth.auth().currentUser?.uid ?? "")
        
        docRef.setData(["stepperValue": stepperValue]) { error in
            if let error = error {
                print("Error saving stepper value: \(error.localizedDescription)")
            } else {
                print("Stepper value saved successfully.")
            }
        }
    }
    
    func fetchStepperValueFromFirestore() {
        let docRef = Firestore.firestore().collection("stepperValue").document(Auth.auth().currentUser?.uid ?? "")
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                if let stepperValue = document.data()?["stepperValue"] as? Int {
                    self.stepperValue = stepperValue
                }
            } else {
                print("Document does not exist in Firestore.")
            }
        }
    }
}
