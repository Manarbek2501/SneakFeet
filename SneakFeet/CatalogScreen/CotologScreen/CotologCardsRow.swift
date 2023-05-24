//
//  CotologCardsRow.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI

struct CotologCardsRow: View {
    
    @State private var clicked: Bool = false
    let title: String
    let description: String
    let image: String
    let price: String
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                VStack {
                    Image(image)
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.system(size: 13, weight: .semibold))
                        Text(description)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color(CGColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)))
                        Text(price)
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
}

struct CotologCardsRow_Previews: PreviewProvider {
    static var previews: some View {
        CotologCardsRow(title: "Dolce", description: "dolce", image: "Dolce", price: "$245")
    }
}


struct Card: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let description: String
    let price: String
}

struct RowView: View {
    let cards: [Card]
    let width: CGFloat
    let height: CGFloat
    let horizontalSpacing: CGFloat
    var body: some View {
        HStack(spacing: horizontalSpacing) {
            ForEach(cards) { card in
                CotologCardsRow(title: card.title, description: card.description, image: card.image, price: card.price)
                    .frame(width: width, height: height)
            }
        }
        .padding()
    }
}

struct StoreCotolog {
    static var cards = [
        Card(title: "Dolce & Gabbana", image: "Dolce", description: "Кеды с принтом граффити", price: "$1251"),
        Card(title: "Jordan", image: "jordan1", description: "Кеды с принтом граффити", price: "$1251"),
        Card(title: "Jordan", image: "jordan2", description: "Кеды с принтом граффити", price: "$1251"),
        Card(title: "Off-White", image: "off-white", description: "Кеды с принтом граффити", price: "$1251"),
        Card(title: "Dolce & Gabbana", image: "Dolce", description: "Кеды с принтом граффити", price: "$1251"),
        Card(title: "Dolce & Gabbana", image: "Dolce", description: "Кеды с принтом граффити", price: "$1251"),
        Card(title: "Dolce & Gabbana", image: "Dolce", description: "Кеды с принтом граффити", price: "$1251"),
        Card(title: "Dolce & Gabbana", image: "Dolce", description: "Кеды с принтом граффити", price: "$1251"),
    ]
}
