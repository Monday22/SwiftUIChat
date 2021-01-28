//
//  ChannelMessageView.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/27/21.
//

import SwiftUI
import Kingfisher

struct ChannelMessageView: View {
    @ObservedObject var viewModel: ChannelMessageViewModel
    
    var body: some View {
        HStack {
            if viewModel.isFromCurrentUser {
                Spacer()
                Text(viewModel.message.text)
                    .padding(12)
                    .background(Color.blue)
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.leading, 100)
                    .font(.system(size: 14))
            } else {
                HStack(alignment: .bottom) {
                    KFImage(URL(string: viewModel.message.user?.profileImageUrl ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text(viewModel.message.text)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .font(.system(size: 14))
                        .clipShape(ChatBubble(isFromCurrentUser: false))
                        .foregroundColor(.black)
                    
                }
                .padding(.horizontal)
                .padding(.trailing, 80)
                Spacer()
            }
        }
    }
}
