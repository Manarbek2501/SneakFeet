//
//  ListDesignView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 25.05.2023.
//

import SwiftUI

struct ListDesignView: View {
    @State var image: String = ""
    @State var title: String = ""
    @State var description: String = ""
    @State var price: String = ""
    var body: some View {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                HStack {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.system(size: 13, weight: .semibold))
                        Text(description)
                            .font(.system(size: 12, weight: .regular))
                        Text(price)
                            .font(.system(size: 12, weight: .semibold))
                            .padding(.top, 2)
                        ZStack {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.black)
                            Text("Add to cart")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 166 ,height: 36)
                        .padding(.top, 8)
                    }
                    .padding(.leading, 16)
                }
                .padding([.leading, .trailing], 16)
                .padding([.bottom, .top], 10)
            }
            .frame(height: 160)
    }
}

struct ListDesignView_Previews: PreviewProvider {
    static var previews: some View {
        ListDesignView()
    }
}