//
//  CartScreenView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI

struct CartScreenView: View {
    @EnvironmentObject var storeModal: StoreModal
    var body: some View {
        NavigationView {
            ZStack {
                Color(CGColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1))
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    Image("Vectors")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.top)
                    Text("Cart is empty")
                        .font(.system(size: 28, weight: .semibold))
                    Text("Find interesting models in the Catalog.")
                        .font(.system(size: 17, weight: .regular))
                    Spacer()
                }
            }
                .navigationTitle("Cart")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    storeModal.savedCards = storeModal.retrieveCards()
                }
        }
    }
}

struct CartScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CartScreenView()
            .environmentObject(StoreModal())
    }
}
