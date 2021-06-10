//
//  ChannelChatViewModel.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/27/21.
//

import Firebase

class ChannelChatViewModel: ObservableObject {
    @Published var messages = [ChannelMessage]()
    @Published var messageToSetVisible: String?
    private var users = [User]()
    let channel: Channel
    
    init(channel: Channel) {
        self.channel = channel
        fetchMessages()
    }
    
    func sendMessage(messageText: String) {
        guard let currentUser = AuthViewModel.shared.currentUser else { return }
        guard let currentUid = currentUser.id else { return }
        guard let channelId = channel.id else { return }
        
        let data: [String: Any] = ["text": messageText,
                                   "fromId": currentUid,
                                   "timestamp": Timestamp(date: Date())]
        
        COLLECTION_CHANNELS.document(channelId).collection("messages").document().setData(data)
        COLLECTION_CHANNELS.document(channelId).updateData(["lastMessage": "\(currentUser.fullname): \(messageText)"])
    }
    
    func fetchMessages() {
        guard let channelId = channel.id else { return }
        guard let currentUid = AuthViewModel.shared.currentUser?.id else { return }
                
        let query = COLLECTION_CHANNELS
            .document(channelId)
            .collection("messages")
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            let messages = changes.compactMap({ try? $0.document.data(as: ChannelMessage.self) })
            
            self.messages.append(contentsOf: messages)
                        
            for (index, message) in self.messages.enumerated() where message.fromId != currentUid {
                
                if let index = self.users.firstIndex(where: { $0.id == message.fromId }) {
                    print("DEBUG: Found user \(self.users[index].username)")
                    self.messages[index].user = self.users[index]
                } else {
                    UserService.fetchUser(withUid: message.fromId) { user in
                        print("DEBUG: Did fetch user \(user)")
                        self.users.append(user)
                        self.messages[index].user = user
                        self.messageToSetVisible = self.messages.last?.id
                    }
                }
            }
        }
    }
}

// FIXME: Performance Improvement

/*
 
 Problem:
 Fetching user repeatedly unecessarily
 Only need to fetch each member of chat once
 Then link that user to all of their messages in the chat
 
 1. use dictionary to grab unique user ids for each message
 2. fetch user and figure out how to link one user to multiple messages.
 3. Use dictionary?? [User: [ChannelMessages]] ---> This creates a data structure that has a one to many relationship
 
 */
