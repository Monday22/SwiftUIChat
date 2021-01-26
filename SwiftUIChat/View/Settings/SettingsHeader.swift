//
//  SettingsHeader.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import SwiftUI
import Kingfisher

struct SettingsHeader: View {
    var user: User
    
    var body: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .padding(.leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullname)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                
                Text(user.status.description)
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
        .frame(height: 80)
        .background(Color.white)
    }
}

