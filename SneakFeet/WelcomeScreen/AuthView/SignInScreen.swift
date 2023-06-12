//
//  SignInScreen.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignInScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var resetPassword: String = ""
    @EnvironmentObject var viewModal: AuthViewModal
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    @State private var showBottomSheet: Bool = false
    @State private var errorString: String?
    @State private var showAlert: Bool = false
    @State private var showSignInAlert: Bool = false
    @State private var isPasswordVisible: Bool = false
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
                        HStack {
                            VStack {
                                if self.isPasswordVisible {
                                    TextField("Password", text: $password)
                                        .autocapitalization(.none)
                                        .padding()
                                } else {
                                    SecureField("Password", text: $password)
                                        .autocapitalization(.none)
                                        .padding()
                                }
                            }
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: self.isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color.black)
                                
                            }
                            .padding()
                        }
                    }
                    .frame(height: 48)
                    
                    HStack {
                        Spacer()
                        Text("Forgot password?")
                            .foregroundColor(Color(CGColor(red: 0.695, green: 0.695, blue: 0.695, alpha: 1)))
                            .onTapGesture {
                                showBottomSheet = true
                            }
                            .sheet(isPresented: $showBottomSheet) {
                                VStack {
                                    Spacer()
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                                        TextField("Email", text: $resetPassword).autocapitalization(.none)
                                            .keyboardType(.emailAddress)
                                            .padding()
                                        
                                    }
                                    .frame(height: 48)
                                    Spacer()
                                    CustomButton(title: "Reset password")
                                        .padding(.bottom, 20)
                                        .onTapGesture {
                                            AuthViewModal.resetPassword(email: self.resetPassword) { (result) in
                                                switch result {
                                                case .success(_):
                                                    break
                                                case .failure(let failure):
                                                    self.errorString = failure.localizedDescription
                                                }
                                            }
                                            self.showAlert = true
                                        }
                                        .alert(isPresented: $showAlert) {
                                            Alert(title: Text("Password Reset"), message: Text(self.errorString ?? "Success. Reset email sent successfully. Check your email"), dismissButton: .default(Text("OK")))
                                        }
                                        .ignoresSafeArea(.keyboard)
                                }
                                .padding([.leading, .trailing], 16)
                                .presentationDetents([.medium])
                                .presentationDragIndicator(.hidden)
                            }
                    }
                }
                .padding(.top, 62)
                Spacer()
                CustomButton(title: "Sign In")
                    .padding(.bottom, 20)
                    .onTapGesture {
                        Task {
                            try await viewModal.signIn(username: username, password: password)
                        }
                        self.showSignInAlert = true
                    }
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.7)
                    .alert(isPresented: $showSignInAlert) {
                        Alert(title: Text("Attension"), message: Text(viewModal.error ?? "Welcome to Sneaker Store App"), dismissButton: .default(Text("OK")))
                    }
                    .onChange(of: viewModal.error) { error in
                        showSignInAlert = (error != nil)
                    }
                    .ignoresSafeArea(.keyboard)
            }
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


extension SignInScreen: AuthFormProtocol {
    var formIsValid: Bool {
        return !username.isEmpty
        && username.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
            .environmentObject(AuthViewModal())
    }
}
