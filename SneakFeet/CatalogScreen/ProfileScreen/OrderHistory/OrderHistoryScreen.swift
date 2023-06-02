//
//  OrderHistoryScreen.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 01.06.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderHistoryScreen: View {
    @EnvironmentObject var orderHistory: CatalogModalData
    @Environment(\.dismiss) var dismiss
    var array: [HistoryModel] = []
    var body: some View {
        if orderHistory.retrieveOrder().isEmpty {
            EmptyOrderHistoryScreen()
        } else {
            NavigationView {
                ZStack {
                    Color(CGColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1))
                        .edgesIgnoringSafeArea(.top)
                    List {
                        ForEach(orderHistory.retrieveOrder()) { item in
                            NavigationLink {
                                DetailOrderHistoryScreen(navTitle: item.order, date: item.creationDate, items: item.items, price: item.price, image: item.orderedImage, title: item.title, description: item.description, item: item.item, prices: item.prices)
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                Section {
                                    OrderHistoryView(image: item.orderedImage, order: item.order, date: item.creationDate, items: item.items, price: item.price)
                                }
                            }
                            
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("Order History")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .medium))
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
            }
        }
    }
}
struct EmptyOrderHistoryScreen: View {
    @Environment(\.dismiss) var dismiss
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
                    Text("Order is empty")
                        .font(.system(size: 28, weight: .semibold))
                    Text("Here will be the history of your orders.")
                        .font(.system(size: 17, weight: .regular))
                    Spacer()
                }
            }
            .navigationTitle("Order History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                        .font(.system(size: 23, weight: .medium))
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
}
struct OrderHistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryScreen()
            .environmentObject(CatalogModalData())
    }
}
