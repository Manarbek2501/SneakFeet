//
//  AccountInfoScreenView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI

struct AccountInfoScreenView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModal: AuthViewModal
    @State private var isPasswordVisible: Bool = false
    @State private var isNewPasswordVisible: Bool = false
    @State private var isShowingAlert: Bool = false
    
    var bindingToUsername: Binding<String> {
            Binding<String>(
                get: { viewModal.currentUser?.username ?? "" },
                set: { newValue in
                    if var currentUser = viewModal.currentUser {
                        currentUser.username = newValue
                    }
                }
            )
        }
    
    var body: some View {
            NavigationView {
                VStack {
                    VStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                            TextField("Username", text: bindingToUsername)
                                .padding()
                        }
                        .frame(height: 48)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                        HStack {
                            VStack {
                                if self.isNewPasswordVisible {
                                    TextField("Old password", text: $viewModal.changeOldPassword)
                                        .autocapitalization(.none)
                                        .padding()
                                } else {
                                    SecureField("Old password", text: $viewModal.changeOldPassword)
                                        .autocapitalization(.none)
                                        .padding()
                                }
                            }
                            Button {
                                isNewPasswordVisible.toggle()
                            } label: {
                                Image(systemName: self.isNewPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color.black)
                            }
                            .padding()
                        }
                    }
                    .frame(height: 48)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                        HStack {
                            VStack {
                                if self.isPasswordVisible {
                                    TextField("New password", text: $viewModal.changeNewPassword)
                                        .autocapitalization(.none)
                                        .padding()
                                } else {
                                    SecureField("New password", text: $viewModal.changeNewPassword)
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
                    }
                    .padding(.top, 62)
                    Spacer()
                    CustomButton(title: "Save changes")
                        .padding(.bottom, 16)
                        .onTapGesture {
                            viewModal.changePassword(newPassword: viewModal.changeNewPassword, currentPassword: viewModal.changeOldPassword)
                            viewModal.changeOldPassword = ""
                            viewModal.changeNewPassword = ""
                            isShowingAlert = true
                        }
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.7)
                        .alert(isPresented: $isShowingAlert) {
                            Alert(
                                title: Text("Attention"),
                                message: Text(viewModal.alertText),
                                dismissButton: .default(Text("OK")) {
                                    dismiss()
                                }
                            )
                        }
                }
                .padding([.leading, .trailing], 16)
                .navigationTitle("Account Information")
                .navigationBarTitleDisplayMode(.inline)
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
extension AccountInfoScreenView: AuthFormProtocol {
    var formIsValid: Bool {
        return !viewModal.changeOldPassword.isEmpty
        && !viewModal.changeNewPassword.isEmpty
        && viewModal.changeNewPassword.count > 5
        && viewModal.changeOldPassword != viewModal.changeNewPassword
    }
}

struct AccountInfoScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoScreenView()
            .environmentObject(AuthViewModal())
    }
}
