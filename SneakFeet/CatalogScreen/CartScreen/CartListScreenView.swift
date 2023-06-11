//
//  CartListScreenView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 25.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseDatabase
import FirebaseFirestore

enum CartScreenState {
    case isEmpty
    case isNotEmpty
}
struct CartListScreenView: View {
    @EnvironmentObject var cards: StoreModal
    @EnvironmentObject var catalogModal: CatalogModalData
    @EnvironmentObject var cartModel: CartModalData
    
    var body: some View {
        if cartModel.cartValue.isEmpty {
            CartScreenView()
        } else {
            ListCartScreenView(orderItems: HistoryModel(order: "", orderedImage: [], creationDate: "", items: "", price: "", title: [], description: [], item: [], prices: []))
        }
    }
}

struct ListCartScreenView: View {
    @EnvironmentObject var cards: StoreModal
    @EnvironmentObject var catalogModal: CatalogModalData
    @EnvironmentObject var cartModel: CartModalData
    @EnvironmentObject var authModel: AuthViewModal
    let orderItems: HistoryModel
    @Environment(\.dismiss) var dismiss
    @State private var showOrderAlert: Bool = false
    @State private var showBottomSheets: Bool = false
    
    var totalPrice: Int {
        return cartModel.cartValue.reduce(0) { $0 + ($1.stepperValues * Int($1.price)!) }
    }
    
    var totalItems: Int {
        return cartModel.cartValue.reduce(0) { $0 + ($1.stepperValues * Int($1.item)!) }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(CGColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1))
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    List {
                        Section {
                            ForEach(Array(cartModel.cartValue.enumerated()), id: \.element) { index, item in
                                ListDesignView(image: item.image , title: item.title , description: item.description , price: item.price, stepperValue: item.stepperValues, index: index)
                            }
                            .onDelete { indices in
                                cartModel.deleteFromCart(indices: indices)
                            }
                        }
                        if !cartModel.cartValue.isEmpty {
                            Section {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 0)
                                        .fill(Color.white)
                                    HStack {
                                        Text("\(totalItems) items: Total (Including Delivery) ")
                                        Spacer()
                                        Text("$\(totalPrice)")
                                    }
                                }
                                .frame(height: 50)
                            }
                        }
                    }
                    .listStyle(.plain)
                    CustomButton(title: "Confirm order")
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom, 23)
                        .disabled(totalItems == 0)
                        .opacity(totalItems == 0 ? 0.7 : 1)
                        .onTapGesture {
                            showOrderAlert = true
                        }
                }
                .alert("Proceed with payment", isPresented: $showOrderAlert) {
                    Button(role: .cancel) {
                        showOrderAlert = false
                    } label: {
                        Text("Cancel")
                    }
                    Button(role: .none) {
                        showBottomSheets = true
                        addToOrderHistory(totalItems, totalPrice)
                    } label: {
                        Text("Confirm")
                    }
                } message: {
                    Text("Are you sure you want to confirm?")
                }
                .sheet(isPresented: $showBottomSheets) {
                    CartBottomSheet(showBottomSheet: $showBottomSheets)
                        .presentationDetents([.medium, .height(505)])
                        .presentationDragIndicator(.hidden)
                }
            }
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func addToOrderHistory(_ totalItems: Int, _ totalPrice: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDate = dateFormatter.string(from: Date())
        
        let order = String(cartModel.cartValue.count)
        let items = String(totalItems)
        var imageArray = [String]()
        let priceString = String(totalPrice)
        var title = [String]()
        var description = [String]()
        var stepperItem = [String]()
        var prices = [Int]()
        
        for card in cartModel.cartValue {
            let orderImage = card.image
            imageArray.append(orderImage)
            let orderTitle = card.title
            title.append(orderTitle)
            let orderDescription = card.description
            description.append(orderDescription)
            let item = card.stepperValues
            stepperItem.append(String(item))
            let orderPrice = card.price
            prices.append(Int(orderPrice)!)
        }
        catalogModal.saveOrderHistoryForCurrentUser(order: order, orderedImage: imageArray, creationDate: currentDate, items: items, price: priceString, title: title, description: description, item: stepperItem, prices: prices)
        Task {
            await  catalogModal.fetchOrderData()
        }
    }
}

struct CartListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CartListScreenView()
            .environmentObject(StoreModal())
            .environmentObject(CatalogModalData())
            .environmentObject(CartModalData())
    }
}
