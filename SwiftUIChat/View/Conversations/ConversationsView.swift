//
//  ConversationsView.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import SwiftUI

struct ConversationsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    Text("Hello")
                }
            }
            .navigationTitle("Chats")
        }
    }
}
