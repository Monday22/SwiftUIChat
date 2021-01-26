//
//  MessageViewModel.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/26/21.
//

import Foundation

struct MessageViewModel {
    let message: Message
    
    var currentUid: String { return AuthViewModel.shared.userSession?.uid ?? "" }
    
    var isFromCurrentUser: Bool { return message.fromId == currentUid }
    
    var profileImageUrl: URL? {
        return URL(string: message.user?.profileImageUrl ?? "")
    }
    
    var fullname: String {
        return message.user?.fullname ?? ""
    }
}
