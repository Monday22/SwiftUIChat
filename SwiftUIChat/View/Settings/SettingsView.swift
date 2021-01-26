//
//  SettingsView.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self.viewModel = EditProfileViewModel(user: user)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    
                    NavigationLink(
                        destination: EditProfileView(viewModel: viewModel),
                        label: {
                            SettingsHeader(user: viewModel.user)
                                .padding(.vertical)
                        })
                    
                    VStack(spacing: 1) {
                        ForEach(SettingsCellViewModel.allCases, id: \.self) { viewModel in
                            SettingsCell(viewModel: viewModel)
                        }
                    }
                    
                    Button(action: { AuthViewModel.shared.signout() }, label: {
                        Text("Log Out")
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: UIScreen.main.bounds.width, height: 50)
                            .background(Color.white)
                    })
                    
                    Spacer()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

