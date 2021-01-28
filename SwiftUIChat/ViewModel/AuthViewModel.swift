//
//  AuthViewModel.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import SwiftUI
import Firebase

class AuthViewModel: NSObject, ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var didSendResetPasswordLink = false
    @Published var didRegister = false
    private var tempCurrentUser: FirebaseAuth.User?
    
    static let shared = AuthViewModel()
    
    override init() {
        super.init()
        tempCurrentUser = nil
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Login failed: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error: \(error.localizedDescription)")
                return
            }

            guard let user = result?.user else { return }
            
            let data: [String: Any] = ["email": email,
                                       "username": username,
                                       "fullname": fullname,
                                       "uid": user.uid,
                                       "status": UserStatus.notConfigured.rawValue]
            
            COLLECTION_USERS.document(user.uid).setData(data) { _ in
                self.tempCurrentUser = user
                self.didRegister = true
            }
        }
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempCurrentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { profileImageUrl in
            COLLECTION_USERS.document(uid).updateData(["profileImageUrl": profileImageUrl]) { _ in
                self.userSession = self.tempCurrentUser
                self.fetchUser()
            }
        }
    }
    
    func signout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func resetPassword(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Failed to send link with error \(error.localizedDescription)")
                return
            }
            
            self.didSendResetPasswordLink = true
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        UserService.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
}
