//
//  OrderHistoryView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 01.06.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderHistoryView: View {
    @EnvironmentObject var orderHistory: CatalogModalData
    let image: [String]
    let order: String
    let date: String
    let items: String
    let price: String
    
    var body: some View {
        HStack {
            ImagesGridView(images: image)
            VStack(alignment: .leading, spacing: 2) {
                Text("Order #\(order)")
                    .font(.system(size: 17, weight: .semibold))
                Text(date)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color(CGColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)))
                Text("\(items) items • $\(price)")
                    .font(.system(size: 12, weight: .semibold))
            }
            .padding(.leading, 10)
            Spacer()
        }
        .padding(.trailing, 12)
    }
}
struct ImagesGridView: View {
    let images: [String]

    var body: some View {
        HStack(spacing: 4) {
            ForEach(images, id: \.self) { image in
                AnimatedImage(url: URL(string: image))
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(12)
            }
        }
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView(image: [], order: "", date: "", items: "", price: "")
            .environmentObject(CatalogModalData())
    }
}
