//
//  EditProfileViewModel.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
        
    func updateProfileImage(_ image: UIImage) {
        guard let uid = user.id else { return }
        
        Storage.storage().reference(forURL: user.profileImageUrl).delete { _ in
            ImageUploader.uploadImage(image: image, type: .profile) { profileImageUrl in
                COLLECTION_USERS.document(uid).updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.user.profileImageUrl = profileImageUrl
                }
            }
        }
    }
    
    func updateName(_ name: String) {
        guard let uid = user.id else { return }
        COLLECTION_USERS.document(uid).updateData(["fullname": name]) { _ in
            self.user.fullname = name
        }
    }
    
    func updateUserStatus(_ status: UserStatus) {
        guard let uid = user.id else { return }
        COLLECTION_USERS.document(uid).updateData(["status": status.rawValue]) { _ in
            self.user.status = status
        }
    }
}
