//
//  ChatViewModel.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/26/21.
//

import SwiftUI
import Firebase

class ChatViewModel: ObservableObject {
    let user: User
    @Published var messages = [Message]()
    
    init(user: User) {
        self.user = user
        fetchMessages()
    }
    
    func fetchMessages() {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        guard let uid = user.id else { return }
        
        let query = COLLECTION_MESSAGES.document(currentUid).collection(uid)
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            
            for (index, message) in messages.enumerated() where message.fromId != currentUid {
                messages[index].user = self.user
            }
            
            self.messages.append(contentsOf: messages)
        }
    }
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = AuthViewModel.shared.currentUser?.id else { return }
        guard let uid = user.id else { return }
        
        let currentUserRef = COLLECTION_MESSAGES.document(currentUid).collection(uid).document()
        let receivingUserRef = COLLECTION_MESSAGES.document(uid).collection(currentUid)
        let receivingRecentRef = COLLECTION_MESSAGES.document(uid).collection("recent-messages")
        let currentRecentRef =  COLLECTION_MESSAGES.document(currentUid).collection("recent-messages")
        
        let messageID = currentUserRef.documentID
        
        let data: [String: Any] = ["text": messageText,
                                   "id": messageID,
                                   "fromId": currentUid,
                                   "toId": uid,
                                   "read": false,
                                   "timestamp": Timestamp(date: Date())]
        
        currentUserRef.setData(data)
        currentRecentRef.document(uid).setData(data)

        receivingUserRef.document(messageID).setData(data)
        receivingRecentRef.document(currentUid).setData(data)
    }
}
