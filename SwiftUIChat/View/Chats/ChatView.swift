//
//  ChatView.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/26/21.
//

import SwiftUI

struct ChatView: View {
    let user: User
    @ObservedObject var viewModel: ChatViewModel
    @State private var messageText: String = ""
    @State private var selectedImage: UIImage?
    
    init(user: User) {
        self.user = user
        self.viewModel = ChatViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.messages) { message in
                        MessageView(viewModel: MessageViewModel(message: message))
                    }
                }
            }.padding(.top)
            
            CustomInputView(inputText: $messageText,
                            selectedImage: $selectedImage,
                            action: sendMessage)
                .padding()
        }
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func sendMessage() {
        if let image = selectedImage {
            viewModel.send(type: .image(image))
            selectedImage = nil
        } else {
            viewModel.send(type: .text(messageText))
            messageText = ""
        }
    }
}
