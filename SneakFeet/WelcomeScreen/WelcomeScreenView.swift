//
//  WelcomeScreenView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI

struct WelcomeScreenView: View {
    var body: some View {
        NavigationStack {
            VStack{
                Image("welcomePage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.top)
                VStack(spacing: 24) {
                    Text("Welcome to the biggest sneakers store app")
                        .font(.system(size: 28, weight: .semibold))
                        .multilineTextAlignment(.center)
                    NavigationLink {
                        SignUpScreen()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        CustomButton(title: "Sign Up")
                    }
                    NavigationLink {
                        SignInScreen()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("I already have an account")
                            .foregroundColor(Color.black)
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                .padding([.leading, .trailing], 16)
                .padding(.bottom, 74)
            }
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
