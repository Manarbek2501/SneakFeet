//
//  CartBottomSheet.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 09.06.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartBottomSheet: View {
    @EnvironmentObject var cartModel: CartModalData
    @Binding var showBottomSheet: Bool
    var body: some View {
            Group {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                        .frame(height: 538)
                    ZStack {
                        VStack {
                            HStack {
                                ForEach(Array(cartModel.cartValue.enumerated()), id: \.element) { index, image in
                                    ZStack {
                                        if index == 0 || index == 1 {
                                            Circle()
                                                .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                                                .frame(width: 150, height: 150)
                                            AnimatedImage(url: URL(string: image.image))
                                                .resizable()
                                                .frame(width: 115, height: 115)
                                                .cornerRadius(15)
                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 40)
                            Text("Your order is succesfully\n placed. Thanks!")
                                .font(.system(size: 28, weight: .semibold))
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 24)
                            CustomButton(title: "Get back to shopping")
                                .onTapGesture {
                                    showBottomSheet = false
                                }
                        }
                        .padding([.leading, .trailing], 16)
                        Image("orderBack")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 365)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.all)
        }
}
