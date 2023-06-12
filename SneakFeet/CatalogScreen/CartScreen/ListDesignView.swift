//
//  ListDesignView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 25.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListDesignView: View {
    @EnvironmentObject var cartModel: CartModalData
    var image: String = ""
    var title: String = ""
    var description: String = ""
    var price: String = ""
    @Binding var stepperValue: Int
    var index: Int
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.white)
            HStack {
                AnimatedImage(url: URL(string: image))
                    .resizable()
                    .frame(width: 166, height: 166)
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 13, weight: .semibold))
                    Text(description)
                        .font(.system(size: 12, weight: .regular))
                    Text("$\(price)")
                        .font(.system(size: 12, weight: .semibold))
                        .padding(.top, 4)
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.black)
                        CustomStepper(stepperValue: $stepperValue, index: index)
                    }
                    .frame(width: 166 ,height: 36)
                    .padding(.top, 12)
                }
                .padding(.leading, 16)
            }
            .padding([.leading, .trailing], 16)
            .padding([.bottom, .top], 10)
        }
        .frame(height: 160)
        .onAppear {
            Task {
                await cartModel.fetchData()
            }
        }
    }
}

struct ListDesignView_Previews: PreviewProvider {
    static var previews: some View {
        ListDesignView(stepperValue: .constant(1), index: 0)
            .environmentObject(CartModalData())
    }
}

