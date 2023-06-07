//
//  AuthViewModel.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 27.05.2023.
//

import Foundation
import Firebase
import FirebaseAuth
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
    @Published var error: String?
    @Published var alertText: String = ""
    
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
            self.error = error.localizedDescription
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
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let credential = EmailAuthProvider.credential(withEmail: currentUser.email ?? "", password: currentPassword)
        currentUser.reauthenticate(with: credential) { [weak self] authResult, error in
            if let error = error {
                print("Reauthentication failed: \(error.localizedDescription)")
                self?.alertText = "\(error.localizedDescription)"
                return
            }
            
            currentUser.updatePassword(to: newPassword) { [weak self] error in
                if let error = error {
                    print("Password update failed: \(error.localizedDescription)")
                    self?.alertText = "\(error.localizedDescription)"
                } else {
                    
                    print("Password updated successfully!")
                    self?.alertText = "Password updated successfully!"
                    
                    let db = Firestore.firestore()
                    let userRef = db.collection("users").document(currentUser.uid)
                    
                    userRef.updateData(["password": newPassword]) { error in
                        if let error = error {
                            print("Firestore update failed: \(error.localizedDescription)")
                        } else {
                            print("Firestore update successful!")
                        }
                    }
                }
            }
        }
    }
}
