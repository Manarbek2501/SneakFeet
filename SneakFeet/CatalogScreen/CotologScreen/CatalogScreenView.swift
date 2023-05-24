//
//  CatalogScreenView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI

struct CatalogScreenView: View {
    
    let itemPerRow: CGFloat = 2
    let horizontalSpacing: CGFloat = 8
    let height: CGFloat = 282
    
    let cards: [Card] = StoreCotolog.cards
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color(CGColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1))
                        .edgesIgnoringSafeArea(.top)
                    ScrollView {
                        VStack {
                            ForEach(0..<cards.count) { i in
                                if i % Int(itemPerRow) == 0 {
                                    buildView(rowIndex: i, geometry: geometry)
                                }
                            }
                            .padding(.top, -25)
                            .padding(.leading, -8)
                        }
                        .padding(.top, 20)
                    }
                }
            }
            .navigationTitle("Hello, Sneakerhead!")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func buildView(rowIndex: Int, geometry: GeometryProxy) -> RowView? {
        var rowCards = [Card]()
        for itemIndex in 0..<Int(itemPerRow) {
            if rowIndex + itemIndex < cards.count {
                rowCards.append(cards[rowIndex + itemIndex])
            }
        }
        if !rowCards.isEmpty {
            return RowView(cards: rowCards, width: getWidth(geometry: geometry), height: height, horizontalSpacing: horizontalSpacing)
        }
        
        return nil
    }
    
    func getWidth(geometry: GeometryProxy) -> CGFloat {
        let width: CGFloat = (geometry.size.width - horizontalSpacing * (itemPerRow + 1)) / itemPerRow
        return width
    }
}

struct CatalogScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogScreenView()
    }
}
