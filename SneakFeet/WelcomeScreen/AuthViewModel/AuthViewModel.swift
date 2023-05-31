//
//  AuthViewModel.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 27.05.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

protocol AuthFormProtocol {
    var formIsValid: Bool {get}
}

@MainActor
class AuthViewModal: ObservableObject {
    @Published var userSessions: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var changeUsername: String = ""
    @Published var changeOldPassword: String = ""
    @Published var changeNewPassword: String = ""
    
    init() {
        self.userSessions = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
        
        self.changeOldPassword = self.currentUser?.password ?? ""
    }
    
    func signIn(username: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: username, password: password)
            self.userSessions = result.user
            await fetchUser()
        } catch {
            print("DEBUG: printed with erroe \(error.localizedDescription)")
        }
    }
    
    func createUser(username: String, password: String, repeatPassword: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: username, password: password)
            self.userSessions = result.user
            let user = User(id: result.user.uid, username: username, password: password)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch  {
            print("DEBUG: Create user with erroe \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSessions = nil
            self.currentUser = nil
        } catch  {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    static func resetPassword(email: String, resetCompletion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        }
    }
    
    func changePassword(newPassword: String, currentPassword: String) {
        guard let user = Auth.auth().currentUser else {
            // User is not signed in
            return
        }
        
        // Check if the user has a password
        if user.providerData.isEmpty {
            print("User does not have a password")
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: user.email!, password: currentPassword)
        
        // Re-authenticate the user with their current password
        user.reauthenticate(with: credential) { _, error in
            if let error = error {
                // Re-authentication failed
                print("Reauthentication failed: \(error.localizedDescription)")
                return
            }
            
            // Re-authentication successful, update the password
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    // Password update failed
                    print("Password update failed: \(error.localizedDescription)")
                } else {
                    // Password updated successfully
                    print("Password updated successfully")
                }
            }
        }
    }
}
