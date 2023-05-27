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
    @State private var changeUsername: String = ""
    @State private var changeOldPassword: String = ""
    var body: some View {
        if let user = viewModal.currentUser {
            NavigationView {
                VStack {
                    VStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                            TextField(user.username, text: $changeUsername)
                                .padding()
                        }
                        .frame(height: 48)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                            SecureField(user.password, text: $changeOldPassword)
                                .padding()
                        }
                        .frame(height: 48)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)))
                            TextField("Change password", text: $changeUsername)
                                .padding()
                        }
                        .frame(height: 48)
                    }
                    .padding(.top, 62)
                    Spacer()
                    CustomButton(title: "Save changes")
                        .padding(.bottom, 16)
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
}

struct AccountInfoScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoScreenView()
            .environmentObject(AuthViewModal())
    }
}
