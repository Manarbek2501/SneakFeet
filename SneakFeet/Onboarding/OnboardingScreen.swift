//
//  OnboardingScreen.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI

struct OnboardingScreen: View {
    @State private var selectedTab = 0
    @Binding var screenState: ScreenState
    var body: some View {
            ZStack{
                TabView(selection: $selectedTab) {
                    FirstOnboardingScreen().tag(0)
                    SecondOnboardingScreen().tag(1)
                    ThirdOnboardingScreen().tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(CGColor(red: 0, green: 0, blue: 0, alpha: 0.3)))
                        .frame(height: 288)
                    VStack {
                        dotIndicators
                        .padding(.top, 32)
                        Text("Fast shipping")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundColor(Color.white)
                            .padding(.top, 30)
                        Text("Get all of your desired sneakers in one place.")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(Color.white)
                            .padding(.bottom, 24)
                            .padding(.top, 5)
                        CustomButton(title: selectedTab == 2 ? "Finish" : "Next")
                            .onTapGesture {
                                withAnimation {
                                    if selectedTab == 0 {
                                        selectedTab = 1
                                    } else if selectedTab == 1 {
                                        selectedTab = 2
                                    } else if selectedTab == 2 {
                                        screenState = .welcomeScreen
                                    }
                                    UserDefaults.standard.onBoarding = true
                                }
                            }
                            .padding(.bottom, 58)
                    }
                    .padding([.leading, .trailing], 16)
                }
                .padding(.top, 565)
            }
            .ignoresSafeArea()
    }
    
    var dotIndicators: some View {
        HStack(spacing: 24) {
            Circle()
                .fill(selectedTab == 0 ? Color.white : Color(CGColor(red: 255, green: 255, blue: 255, alpha: 0.4)))
                .frame(width: 8, height: 8)
            Circle()
                .fill(selectedTab == 1 ? Color.white : Color(CGColor(red: 255, green: 255, blue: 255, alpha: 0.4)))
                .frame(width: 8, height: 8)
            Circle()
                .fill(selectedTab == 2 ? Color.white : Color(CGColor(red: 255, green: 255, blue: 255, alpha: 0.4)))
                .frame(width: 8, height: 8)
        }
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen(screenState: .constant(.onboarding))
    }
}
