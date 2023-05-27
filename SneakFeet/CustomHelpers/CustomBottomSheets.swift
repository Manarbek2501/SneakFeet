//
//  CustomBottomSheets.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 27.05.2023.
//

import SwiftUI

struct CustomBottomSheets: View {
    @Binding var showBottomSheets: Bool
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.3)
            if showBottomSheets {
                CustomBottomSheets.bottomSheets()
            }
        }
    }
    static func bottomSheets() -> some View {
        Group {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                    .frame(height: 538)
                ZStack {
                    VStack {
                        Image("Dolce")
                            .padding(.bottom, 60)
                        Text("Your order is succesfully\n placed. Thanks!")
                            .font(.system(size: 28, weight: .semibold))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 24)
                        CustomButton(title: "Get back to shopping")
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


//struct CustomBottomSheets_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomBottomSheets()
//    }
//}
