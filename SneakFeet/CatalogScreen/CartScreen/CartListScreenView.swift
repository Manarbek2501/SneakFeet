//
//  CartListScreenView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 25.05.2023.
//

import SwiftUI

struct CartListScreenView: View {
    @EnvironmentObject var cards: StoreModal
    var body: some View {
        if cards.cards.isEmpty {
            CartScreenView()
        } else {
            NavigationView {
                ZStack {
                    Color(CGColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1))
                        .edgesIgnoringSafeArea(.top)
                    List {
                        Section {
                            ForEach(cards.cards) { item in
                                ListDesignView(image: item.image, title: item.title, description: item.description, price: item.price)
                            }
                            .onDelete(perform: delete)
                        }
                        if !cards.cards.isEmpty {
                            Section {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 0)
                                        .fill(Color.white)
                                    HStack {
                                        Text("4 items: Total (Including Delivery) ")
                                        Text("$1232")
                                    }
                                }
                                .frame(height: 50)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("Cart")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    func delete(indexSet: IndexSet) {
        cards.cards.remove(atOffsets: indexSet)
    }
}

struct CartListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CartListScreenView()
            .environmentObject(StoreModal())
    }
}
