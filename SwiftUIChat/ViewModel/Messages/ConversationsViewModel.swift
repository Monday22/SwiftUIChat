//
//  ConversationsViewModel.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/26/21.
//

import SwiftUI

class ConversationsViewModel: ObservableObject {
    @Published var recentMessages = [Message]()
    private var recentMessagesDictionary = [String: Message]()
    
    func fetchRecentMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages")
        query.order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { document in
                let uid = document.documentID
                guard var message = try? document.data(as: Message.self) else { return }
                
                COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
                    guard let user = try? snapshot?.data(as: User.self) else { return }
                    message.user = user
                    self.recentMessagesDictionary[uid] = message
                    self.recentMessages = Array(self.recentMessagesDictionary.values)
                }
            }
        }
    }
}
