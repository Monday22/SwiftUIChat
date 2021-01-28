//
//  SelectableUser.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/27/21.
//

import Foundation

struct SelectableUser: Identifiable {
    var user: User
    var isSelected: Bool
    
    var id: String { return user.id ?? NSUUID().uuidString }
}
