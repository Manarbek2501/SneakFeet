//
//  SecondOnboardingScreen.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI

struct SecondOnboardingScreen: View {
    var body: some View {
        ZStack {
            Image("SecondScreen")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

struct SecondOnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondOnboardingScreen()
    }
}
