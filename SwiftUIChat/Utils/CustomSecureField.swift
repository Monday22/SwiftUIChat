//
//  CustomSecureField.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import SwiftUI

struct CustomSecureField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    placeholder
                        .foregroundColor(Color(.placeholderText))
                        .padding(.leading, 40)
                }

                HStack {
                    Image(systemName: "lock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(.darkGray))
                    
                    SecureField("", text: $text)
                }
            }
            
            Divider()
                .background(Color(.black))
        }
    }
}
