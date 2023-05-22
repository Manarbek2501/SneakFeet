//
//  SignUpScreen.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI

struct SignUpScreen: View {
    @State private var username: String = ""
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                        TextField("Username", text: $username)
                            .padding()
                    }
                    .frame(height: 48)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                        TextField("Password", text: $username)
                            .padding()
                    }
                    .frame(height: 48)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                        TextField("Repeat password", text: $username)
                            .padding()
                    }
                    .frame(height: 48)
                }
                .padding(.top, 62)
                Spacer()
                CustomButton(title: "Sign Up")
                    .padding(.bottom, 20)
            }
            .padding([.leading, .trailing], 16)
            .navigationTitle("New User")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        WelcomeScreenView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .medium))
                    }
                }
            }
        }
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
