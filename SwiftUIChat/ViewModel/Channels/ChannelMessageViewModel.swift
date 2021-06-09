//
//  ChannelMessageViewModel.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/27/21.
//

import Foundation

struct ChannelMessageViewModel {
    let message: ChannelMessage
    
    var currentUid: String { return AuthViewModel.shared.userSession?.uid ?? "" }
    
    var isFromCurrentUser: Bool { return message.fromId == currentUid }
    
    var fullname: String {
        return message.user?.fullname ?? ""
    }
}
