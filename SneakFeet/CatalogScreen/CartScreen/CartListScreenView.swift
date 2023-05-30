//
//  CartListScreenView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 25.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartListScreenView: View {
    @EnvironmentObject var cards: StoreModal
    @EnvironmentObject var catalogModal: CatalogModalData
    var body: some View {
        if cards.retrieveCards().isEmpty {
            CartScreenView()
        } else {
            ListCartScreenView()
        }
    }
}

struct ListCartScreenView: View {
    @EnvironmentObject var cards: StoreModal
    @EnvironmentObject var catalogModal: CatalogModalData
    @State var savedCards: [CatalogData] = []
    @Environment(\.dismiss) var dismiss
    @State private var showOrderAlert: Bool = false
    @State private var showBottomSheets: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(CGColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1))
                    .edgesIgnoringSafeArea(.top)
                List {
                    Section {
                        ForEach(cards.retrieveCards()) { item in
                            ListDesignView(image: item.image , title: item.title , description: item.description , price: item.price )
                        }
                        .onDelete(perform: delete)
                    }
                    if !savedCards.isEmpty {
                        Section {
                            ZStack {
                                RoundedRectangle(cornerRadius: 0)
                                    .fill(Color.white)
                                HStack {
                                    Text(" items: Total (Including Delivery) ")
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
                    bottomSheet()
                        .presentationDetents([.medium, .height(505)])
                        .presentationDragIndicator(.hidden)
                }
            }
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
               savedCards = cards.retrieveCards()
            }
        }
    }
    func delete(indexSet: IndexSet) {
        savedCards.remove(atOffsets: indexSet)
//        UserDefaults.standard.removeObject(forKey: "catalogInList")
    }
    func bottomSheet() -> some View {
        Group {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .frame(height: 538)
                ZStack {
                    VStack {
                        HStack {
                            ForEach(savedCards) { image in
                                ZStack {
                                    Circle()
                                        .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                                        .frame(width: 150, height: 150)
                                    AnimatedImage(url: URL(string: image.image))
                                        .resizable()
                                        .frame(width: 115, height: 115)
                                        .cornerRadius(15)
                                }
                            }
                        }
                        .padding(.bottom, 40)
                        Text("Your order is succesfully\n placed. Thanks!")
                            .font(.system(size: 28, weight: .semibold))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 24)
                        CustomButton(title: "Get back to shopping")
                            .onTapGesture {
                                showBottomSheets = false
                            }
                    }
                    .padding([.leading, .trailing], 16)
                    Image("orderBack")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 365)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CartListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CartListScreenView()
            .environmentObject(StoreModal())
            .environmentObject(CatalogModalData())
    }
}
