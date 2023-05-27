//
//  ProfileScreenView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 24.05.2023.
//

import SwiftUI

struct ProfileScreenView: View {
    @EnvironmentObject var shoeSizeText: StoreModal
    @EnvironmentObject var viewModal: AuthViewModal
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            ZStack {
                Color(CGColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1))
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    VStack {
                        NavigationLink {
                            AccountInfoScreenView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            BlocksInProfile(blockTitle: "Account Information")
                        }
                        BlocksInProfile(blockTitle: "Order History")
                        NavigationLink {
                            ShoeSizeScreenView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            BlocksInProfile(blockTitle: "Shoe size", shoeSizeText: shoeSizeText.shoeSizeText)
                        }
                        FaqBlocks()
                    }
                    .padding(.top, 32)
                    Spacer()
                    CustomButton(title: "Sign Out")
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom, 23)
                        .onTapGesture {
                            showingAlert = true
                        }
                        .alert("Are you sure you want to sign out?", isPresented: $showingAlert) {
                            Button(role: .cancel) {
                                withAnimation {
                                    showingAlert = false
                                }
                            } label: {
                                Text("Cancel")
                            }
                            Button(role: .destructive) {
                                viewModal.signOut()
                            } label: {
                                Text("Confirm")
                            }

                        }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreenView()
            .environmentObject(StoreModal())
            .environmentObject(AuthViewModal())
    }
}

private struct BlocksInProfile: View {
    var blockTitle: String = ""
    var shoeSizeText: String?
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(height: 52)
            HStack {
                Text(blockTitle)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color.black)
                Spacer()
                Text(shoeSizeText ?? "")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color(CGColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)))
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(CGColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.3)))
            }
            .padding([.leading, .trailing], 16)
        }
    }
}

private struct FaqBlocks: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(height: 126)
            VStack {
               FaqQuestions(questionTitle: "How to know your shoe size?", questionURL: "https://www.2bigfeet.com/pages/measure-your-shoe-size#:~:text=To%20find%20your%20size%2C%20measure,inch%2Dto%2Dsize%20table.")
                Divider()
                FaqQuestions(questionTitle: "How to check the authenticity\nof the shoe?", questionURL: "https://hypestew.com/blogs/news/legit-check")
            }
            .padding()
        }
    }
}

private struct FaqQuestions: View {
    @State private var isPresentWebView = false
    
    var questionTitle: String
    var questionURL: String
    
    var body: some View {
        HStack {
            Text(questionTitle)
                .font(.system(size: 17, weight: .regular))
            Spacer()
            Image(systemName: "arrowshape.turn.up.right")
                .foregroundColor(Color(CGColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.5)))
        }
        .padding([.top, .bottom], 11)
        .onTapGesture {
            isPresentWebView = true
        }
        .fullScreenCover(isPresented: $isPresentWebView, content: {
            NavigationStack {
                WebView(url: URL(string: questionURL)!)
                    .ignoresSafeArea()
                    .navigationTitle("sneakersinfo.com")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.black)
                                .font(.system(size: 23, weight: .medium))
                                .onTapGesture {
                                    isPresentWebView = false
                                }
                        }
                    }
            }
        })
    }
}
