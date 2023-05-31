//
//  OrderHistoryScreen.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 01.06.2023.
//

import SwiftUI

struct OrderHistoryScreen: View {
    var body: some View {
        HStack {
            ZStack {
                Image("Dolce")
            }
            VStack(alignment: .leading) {
                Text("Order #123")
                Text("Date")
                Text("items and price")
                    .padding(.top, 12)
            }
            .padding(.leading, 10)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.trailing, 16)
    }
}

struct OrderHistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryScreen()
    }
}
