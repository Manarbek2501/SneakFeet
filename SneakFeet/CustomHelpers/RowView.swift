//
//  RowView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 30.05.2023.
//

import SwiftUI

struct RowView: View {
    let cards: [CatalogData]
    let width: CGFloat
    let height: CGFloat
    let horizontalSpacing: CGFloat
    var body: some View {
        HStack(spacing: horizontalSpacing) {
            ForEach(cards) { card in
                CotologCardsRow(item: CatalogData(title: card.title, description: card.description, image: card.image, price: card.price), title: card.title, description: card.description, image: card.image, price: card.price)
                    .frame(width: width, height: height)
            }
        }
        .padding()
    }
}
