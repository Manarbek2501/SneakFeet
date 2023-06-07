//
//  CotologCardsRow.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CotologCardsRow: View {
    let item: CatalogData
    @EnvironmentObject var storeModal: StoreModal
    @EnvironmentObject var catalogModal: CatalogModalData
    @EnvironmentObject var cartModel: CartModalData
    @State private var clicked: Bool = false
    let title: String
    let description: String
    let image: String
    let price: Int
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                VStack {
                    AnimatedImage(url: URL(string: image))
                        .resizable()
                        .frame(width: 166, height: 166)
                        .cornerRadius(12)
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.system(size: 13, weight: .semibold))
                        Text(description)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color(CGColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)))
                        Text("$ \(price)")
                            .font(.system(size: 12, weight: .semibold))
                        ZStack {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(clicked ? Color(CGColor(red: 0, green: 0, blue: 0, alpha: 0.7)) : Color.black)
                            Text(clicked ? "Remove" : "Add to cart")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(Color.white)
                        }
                        .onTapGesture {
                            clicked.toggle()
                            if clicked {
                                getCartData(item: item)
                            } else {
                                
                            }
                        }
                        .padding([.leading, .trailing], 4)
                        .frame(height: 40)
                    }
                    .padding(4)
                }
                
            }
            .padding([.leading, .trailing], 4)
        }
    }
    func getCartData(item: CatalogData) {
        let cartModelData = CartModel(title: item.title, image: item.image, description: item.description, price: String(item.price), item: String(item.item))
        cartModel.saveToFirestore(cartModel: cartModelData)
    }
}

struct CotologCardsRow_Previews: PreviewProvider {
    static var previews: some View {
        CotologCardsRow(item: CatalogData(title: "Dolce", description: "Dolce", image: "Dolce", price: 120, item: 0), title: "", description: "", image: "", price: 0)
            .environmentObject(StoreModal())
            .environmentObject(CatalogModalData())
            .environmentObject(CartModalData())
    }
}





