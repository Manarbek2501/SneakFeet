//
//  CustomButton.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.black)
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color.white)
        }
        .frame(height: 54)
    }
}
