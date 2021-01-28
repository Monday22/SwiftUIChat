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
        
        let query = COLLECTION_CHANNELS.document(channelId).collection("messages")
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            let messages = changes.compactMap({ try? $0.document.data(as: ChannelMessage.self) })
                .sorted(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })
            
            self.messages.append(contentsOf: messages)
            
            for (index, message) in self.messages.enumerated() where message.fromId != currentUid {
                UserService.fetchUser(withUid: message.fromId) { user in
                    self.messages[index].user = user
                    self.messageToSetVisible = self.messages.last?.id
                }
            }
        }
    }
}
