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
    let title: String
    let description: String
    let image: String
    let price: Int
    @State var isSelected: Bool
    
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
                                .fill(isSelected ? Color(CGColor(red: 0, green: 0, blue: 0, alpha: 0.7)) : Color.black)
                            Text(isSelected ? "Remove" : "Add to cart")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(Color.white)
                        }
                        .onTapGesture {
                            self.isSelected.toggle()
                            if isSelected {
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
        let cartModelData = CartModel(title: item.title, image: item.image, description: item.description, price: String(item.price), item: String(item.item), clicked: item.clicked)
            cartModel.saveToFirestore(cartModel: cartModelData)
    }
}

struct CotologCardsRow_Previews: PreviewProvider {
    static var previews: some View {
        CotologCardsRow(item: CatalogData(title: "Dolce", description: "Dolce", image: "Dolce", price: 120, item: 0, clicked: false), title: "", description: "", image: "", price: 0, isSelected: false)
            .environmentObject(StoreModal())
            .environmentObject(CatalogModalData())
            .environmentObject(CartModalData())
    }
}





