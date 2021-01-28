//
//  Channel.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/27/21.
//

import FirebaseFirestoreSwift

struct Channel: Identifiable, Decodable {
    @DocumentID var id: String?
    var name: String
    var imageUrl: String?
    var uids: [String]
    var lastMessage: String
}
