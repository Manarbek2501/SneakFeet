//
//  SignUpScreen.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI
import Firebase

struct SignUpScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var repeatPass: String = ""
    @EnvironmentObject var viewModal: AuthViewModal
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                        TextField("Email", text: $username)
                            .autocapitalization(.none)
                            .padding()
                    }
                    .frame(height: 48)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                        SecureField("Password", text: $password)
                            .autocapitalization(.none)
                            .padding()
                    }
                    .frame(height: 48)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                        HStack {
                            SecureField("Repeat password", text: $repeatPass)
                                .autocapitalization(.none)
                                .padding()
                            
                            if !password.isEmpty && !repeatPass.isEmpty {
                                if password == repeatPass {
                                    Image(systemName: "checkmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.systemGreen))
                                        .padding(.trailing, 5)
                                } else {
                                    Image(systemName: "xmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.systemRed))
                                        .padding(.trailing, 5)
                                }
                            }
                        }
                    }
                    .frame(height: 48)
                }
                .padding(.top, 62)
                Spacer()
                CustomButton(title: "Sign Up")
                    .padding(.bottom, 20)
                    .onTapGesture {
                        Task {
                            try await viewModal.createUser(username: username,
                                                           password: password,
                                                           repeatPassword: repeatPass)
                        }
                    }
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.7)
            }
            .padding([.leading, .trailing], 16)
            .navigationTitle("New User")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(.keyboard)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
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

extension SignUpScreen: AuthFormProtocol {
    var formIsValid: Bool {
        return !username.isEmpty
        && username.contains("@")
        && !password.isEmpty
        && password.count > 5
        && repeatPass == password
        && !repeatPass.isEmpty
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
            .environmentObject(AuthViewModal())
    }
}
