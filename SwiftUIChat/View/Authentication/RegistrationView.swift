//
//  RegistrationView.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var password = ""
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State private var showImageSelectorView = false
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            NavigationLink(destination: ProfilePhotoSelectView(),
                           isActive: $viewModel.didRegister,
                           label: {} )
            
            VStack(alignment: .leading, spacing: 12) {
                HStack { Spacer() }
                
                Text("Get started.")
                    .font(.largeTitle)
                    .bold()
                
                Text("Create your account.")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
            }
            .padding(.leading)
            .padding(.bottom, 32)
            
            VStack {
                VStack(spacing: 20) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .cornerRadius(10)
                        .padding(.horizontal, 32)
                    
                    CustomTextField(text: $username, placeholder: Text("Username"), imageName: "person")
                        .padding()
                        .cornerRadius(10)
                        .padding(.horizontal, 32)
                    
                    CustomTextField(text: $fullname, placeholder: Text("Full Name"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal, 32)
                    
                    CustomSecureField(placeholder: Text("Password"), text: $password)
                        .padding()
                        .cornerRadius(10)
                        .padding(.horizontal, 32)
                }
                
                Button(action: {
                    viewModel.register(withEmail: email, password: password,
                                       fullname: fullname, username: username)
                }, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding()
                })
                .shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
                
                Spacer()
                
                Button(action: { mode.wrappedValue.dismiss() }, label: {
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(.blue)
                    .padding(.bottom, 16)
                })
            }
        }
        .onAppear(perform: {
            viewModel.didRegister = false
        })
        .padding(.top, -56)
    }
}

extension RegistrationView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
