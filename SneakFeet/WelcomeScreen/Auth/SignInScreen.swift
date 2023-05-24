//
//  SignInScreen.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI

struct SignInScreen: View {
    @State private var username: String = ""
    @Environment(\.dismiss) var dismiss
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
                }
                .padding(.top, 62)
                Spacer()
                CustomButton(title: "Sign In")
                    .padding(.bottom, 20)
            }
            .padding([.leading, .trailing], 16)
            .navigationTitle("Welcome back!")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(.keyboard)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    withAnimation {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .medium))
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
            }
        }
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
