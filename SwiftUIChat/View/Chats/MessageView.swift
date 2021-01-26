//
//  MessageView.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/26/21.
//

import SwiftUI
import Kingfisher

struct MessageView: View {
    let viewModel: MessageViewModel
    
    var body: some View {
        HStack {
            if viewModel.isFromCurrentUser {
                Spacer()
                Text(viewModel.message.text)
                    .padding()
                    .background(Color.blue)
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.leading, 100)
                    .font(.body)
            } else {
                HStack(alignment: .bottom) {
                    KFImage(viewModel.profileImageUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text(viewModel.message.text)
                        .padding()
                        .background(Color(.systemGray5))
                        .font(.body)
                        .clipShape(ChatBubble(isFromCurrentUser: false))
                        .foregroundColor(.black)
                    
                }
                .padding(.horizontal)
                .padding(.trailing, 100)
                Spacer()
            }
        }
    }
}
