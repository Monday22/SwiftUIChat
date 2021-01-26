//
//  NewMessageViewModel.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/26/21.
//

import SwiftUI

class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        
        COLLECTION_USERS.whereField("uid", isNotEqualTo: uid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.compactMap({ try? $0.data(as: User.self) })
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.contains(lowercasedQuery) })
    }
}
