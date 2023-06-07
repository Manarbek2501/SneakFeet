//
//  OrderHistoryScreen.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 01.06.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseDatabase

struct OrderHistoryScreen: View {
    @EnvironmentObject var orderHistory: CatalogModalData
    @Environment(\.dismiss) var dismiss
    var body: some View {
        if orderHistory.orderHistoryValue.isEmpty {
            EmptyOrderHistoryScreen()
        } else {
            NavigationView {
                ZStack {
                    Color(CGColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1))
                        .edgesIgnoringSafeArea(.top)
                    List {
                        ForEach(orderHistory.orderHistoryValue) { item in
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
                .onAppear {
                    Task {
                        await fetchData()
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
    private func fetchData() async {
        await orderHistory.fetchOrderHistoryForCurrentUser()
    }
}
struct EmptyOrderHistoryScreen: View {
    @EnvironmentObject var orderHistory: CatalogModalData
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
            .onAppear {
                Task {
                    await fetchData()
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
    private func fetchData() async {
        await orderHistory.fetchOrderHistoryForCurrentUser()
    }
}
struct OrderHistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryScreen()
            .environmentObject(CatalogModalData())
    }
}
