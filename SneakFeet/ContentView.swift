//
//  ContentView.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 22.05.2023.
//

import SwiftUI

extension UserDefaults {
    var onBoarding: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "onboardingScreen") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "onboardingScreen")
        }
    }
}

struct ContentView: View {
    @State var screenState: ScreenState = .onboarding
    @EnvironmentObject var viewModal: AuthViewModal
    var body: some View {
        switch screenState {
        case .onboarding:
            if UserDefaults.standard.onBoarding {
                if viewModal.userSessions != nil {
                    MainScreenView()
                } else {
                    WelcomeScreenView()
                }
            } else {
                OnboardingScreen(screenState: $screenState)
            }
        case .welcomeScreen:
            if UserDefaults.standard.onBoarding {
                if viewModal.userSessions != nil {
                    MainScreenView()
                } else {
                    WelcomeScreenView()
                }
            } else {
                OnboardingScreen(screenState: $screenState)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModal())
    }
}
