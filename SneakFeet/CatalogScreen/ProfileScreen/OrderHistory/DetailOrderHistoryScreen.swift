//
//  DetailOrderHistoryScreen.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 01.06.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailOrderHistoryScreen: View {
    
    @EnvironmentObject var orderHistory: CatalogModalData
    @Environment(\.dismiss) var dismiss
    
    let navTitle: String
    let date: String
    let items: String
    let price: String
    
    let image: [String]
    let title: [String]
    let description: [String]
    let item: [String]
    let prices: [Int]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(CGColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1))
                    .edgesIgnoringSafeArea(.top)
                ScrollView {
                    VStack(spacing: 16) {
                        ZStack {
                            Color.white
                            HStack {
                                Text("Ordered")
                                Spacer()
                                Text(date)
                            }
                            .padding([.leading, .trailing], 16)
                        }
                        .frame(height: 50)
                        ZStack {
                            Color.white
                            HStack {
                                Text("\(items) items: Total (Including Delivery) ")
                                Spacer()
                                Text("$\(price)")
                            }
                            .padding([.leading, .trailing], 16)
                        }
                        .frame(height: 50)
                        DetailView(image: image, title: title, description: description, items: item, price: prices)
                    }
                }
                .padding(.top, 26)
                .navigationTitle("Order #\(navTitle)")
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

struct DetailView: View {
    
    @EnvironmentObject var orderHistory: CatalogModalData
    
    let image: [String]
    let title: [String]
    let description: [String]
    let items: [String]
    let price: [Int]
    
    var body: some View {
            ForEach(0..<image.count) { index in
                let image = image[index]
                let title = title[index]
                let description = description[index]
                let item = items[index]
                let price = price[index]
                
                ZStack {
                    Color.white
                    HStack(spacing: 4) {
                        AnimatedImage(url: URL(string: image))
                            .resizable()
                            .frame(width: 140, height: 140)
                            .cornerRadius(12)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(title)
                                .font(.system(size: 13, weight: .semibold))
                            Text(description)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color(CGColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)))
                            Text("\(item) • $\(price)")
                                .font(.system(size: 12, weight: .semibold))
                                .padding(.top, 2)
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    .padding([.leading, .trailing], 16)
                }
                .frame(height: 160)
            }
        }
}

struct DetailOrderHistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailOrderHistoryScreen(navTitle: "Order #",
                                 date: "",
                                 items: "", price: "",
                                 image: [], title: [],
                                 description: [],
                                 item: [], prices: [])
            .environmentObject(CatalogModalData())
    }
}
