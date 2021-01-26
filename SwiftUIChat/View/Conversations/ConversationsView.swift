//
//  ConversationsView.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import SwiftUI

struct ConversationsView: View {
    @State var isShowingNewMessageView = false
    @State var showChat = false
    @State var user: User?
    @ObservedObject var viewModel = ConversationsViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if let user = user {
                NavigationLink(destination: LazyView(ChatView(user: user)),
                               isActive: $showChat,
                               label: {} )
            }
            
            ScrollView {
                VStack {
                    ForEach(viewModel.recentMessages) { message in
                        if let user = message.user {
                            NavigationLink(
                                destination: LazyView(ChatView(user: user)),
                                label: {
                                    ConversationCell(viewModel: MessageViewModel(message: message))
                                })
                        }
                    }
                }.padding()
            }
            
            HStack {
                Spacer()
                
                Button(action: { self.isShowingNewMessageView.toggle() }, label: {
                    Image(systemName: "envelope")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .padding()
                })
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .sheet(isPresented: $isShowingNewMessageView, content: {
                    NewMessageView(show: $isShowingNewMessageView, startChat: $showChat, user: $user)
                })
            }
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetchRecentMessages()
        }
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
    }
}
