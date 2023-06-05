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
        return cartModel.cartValue.reduce(0) { $0 + Int($1.price)! }
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color(CGColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1))
                    .edgesIgnoringSafeArea(.top)
                List {
                    Section {
                        ForEach(cartModel.cartValue) { item in
                            ListDesignView(image: item.image , title: item.title , description: item.description , price: item.price )
                        }
                        .onDelete { indexSet in
                            let cartUUIDs = indexSet.compactMap {
                                UUID(uuidString: cartModel.cartValue[$0].id)
                            }
                            if let firstUUID = cartUUIDs.first {
                                self.delete(with: firstUUID.uuidString)
                            }
                        }
                    }
                    if !cartModel.cartValue.isEmpty {
                        Section {
                            ZStack {
                                RoundedRectangle(cornerRadius: 0)
                                    .fill(Color.white)
                                HStack {
                                    Text("\(catalogModal.items.count) items: Total (Including Delivery) ")
                                    Spacer()
                                    Text("$\(totalPrice)")
                                }
                            }
                            .frame(height: 50)
                        }
                    }
                }
                .onAppear {
                    cartModel.fetchCartForCurrentUserFirestore()
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
                                placeOrder()
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
        }
    }
    func getCurrentUserID() -> String? {
        if let user = Auth.auth().currentUser {
            return user.uid
        }
        return nil
    }
    func delete(with id: String) {
        guard let userID = getCurrentUserID() else {
                print("User is not authenticated.")
                return
            }
        let db = Firestore.firestore()
        db.collection("carts").document("\(userID)").collection("cartItems").whereField("id", isEqualTo: id).getDocuments { (snap, err) in
            if err != nil {
                print("error")
                return
            }
            for i in snap!.documents {
                DispatchQueue.main.async {
                    i.reference.delete()
                }
            }
        }
    }
    
    func placeOrder() {
        let order = String(cartModel.cartValue.count)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDate = dateFormatter.string(from: Date())
        let items = String(catalogModal.items.count)
        var imageArray = [String]()
        
        for card in cartModel.cartValue {
            let orderImage = card.image
            imageArray.append(orderImage)
        }
        
        let priceString = String(totalPrice)
        
        var title = [String]()
        for card in cartModel.cartValue {
            let orderTitle = card.title
            title.append(orderTitle)
        }
        var description = [String]()
        for card in cartModel.cartValue {
            let orderDescription = card.description
            description.append(orderDescription)
        }
        var stepperItem = [String]()
        for card in cartModel.cartValue {
            let item = card.item
            stepperItem.append(item)
        }
        var prices = [Int]()
        for card in cartModel.cartValue {
            let orderPrice = card.price
            prices.append(Int(orderPrice)!)
        }
        
        catalogModal.saveOrderHistoryForCurrentUser(order: order, orderedImage: imageArray, creationDate: currentDate, items: items, price: priceString, title: title, description: description, item: stepperItem, prices: prices)
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
                            ForEach(cartModel.cartValue) { image in
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
            .environmentObject(CartModalData())
    }
}
