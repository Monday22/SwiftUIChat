//
//  ChannelsView.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/27/21.
//

import SwiftUI

struct ChannelsView: View {
    @State var showNewGroupView = false
    @State var showChat = false
    @State var users = [SelectableUser]()
    @ObservedObject var viewModel = ChannelsViewModel()

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if !users.isEmpty {
                NavigationLink(destination: Text("Group chat"),
                               isActive: $showChat,
                               label: {} )
            }
            
            ScrollView {
                VStack {
                    ForEach(viewModel.channels) { channel in
                        NavigationLink(
                            destination:
                                LazyView(ChannelChatView(channel: channel))
                                .onDisappear(perform: {
                                    viewModel.fetchChannels()
                                }),
                            label: {
                                ChannelCell(channel: channel)
                            })
                    }
                }.padding()
            }
            
            HStack {
                Spacer()
                
                Button(action: { self.showNewGroupView.toggle() }, label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding()
                })
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .sheet(isPresented: $showNewGroupView, content: {
                    SelectGroupMembersView(show: $showNewGroupView, startChat: $showChat, users: $users)
                })
            }
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChannelsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsView()
    }
}
