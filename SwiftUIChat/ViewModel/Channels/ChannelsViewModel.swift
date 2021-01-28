//
//  ChannelsViewModel.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/27/21.
//

import Foundation

class ChannelsViewModel: ObservableObject {
    @Published var channels = [Channel]()
    
    init() {
        fetchChannels()
    }
    
    func fetchChannels() {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        COLLECTION_CHANNELS.whereField("uids", arrayContains: uid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.channels = documents.compactMap({ try? $0.data(as: Channel.self) })
        }
    }
}
