//
//  Message.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import FirebaseFirestoreSwift
import Firebase

struct Message: Identifiable, Decodable {
    let id: String
    let fromId: String
    let toId: String
    let timestamp: Timestamp
    let text: String
    var user: User?
}
