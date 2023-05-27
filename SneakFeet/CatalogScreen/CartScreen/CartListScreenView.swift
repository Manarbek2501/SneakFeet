//
//  CartListScreenView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 25.05.2023.
//

import SwiftUI

struct CartListScreenView: View {
    @EnvironmentObject var cards: StoreModal
    @State private var showOrderAlert: Bool = false
    @State private var showBottomSheets: Bool = false
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
                                        Text("1 items: Total (Including Delivery) ")
                                        Text("$1232")
                                    }
                                }
                                .frame(height: 50)
                            }
                        }
                    }
                    .listStyle(.plain)
                    Group {
                        CustomButton(title: "Confirm order")
                            .padding([.leading, .trailing], 16)
                            .onTapGesture {
                                showOrderAlert = true
                            }
                            .alert("Proceed with payment", isPresented: $showOrderAlert) {
                                Button(role: .cancel) {
                                    showOrderAlert = false
                                } label: {
                                    Text("Cancel")
                                }
                                Button(role: .none) {
                                    showBottomSheets = true
                                } label: {
                                    Text("Confirm")
                                }
                            } message: {
                                Text("Are you sure you want to confirm?")
                            }
                    }
                    .padding(.bottom, 13)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .sheet(isPresented: $showBottomSheets) {
                        CustomBottomSheets.bottomSheets()
                        .presentationDetents([.medium, .height(500)])
                        .presentationDragIndicator(.hidden)
                    }
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
