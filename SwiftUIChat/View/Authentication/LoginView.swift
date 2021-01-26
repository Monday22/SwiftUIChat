//
//  LoginView.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import SwiftUI
import ProgressHUD

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showProgressHUD = true
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack { Spacer() }
                    
                    Text("Hello.")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.blue)

                }
                .padding(.leading)
                .padding(.bottom, 32)
                                    
                VStack(spacing: 20) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)
                        .padding(.horizontal, 32)
                    
                    CustomSecureField(placeholder: Text("Password"), text: $password)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)
                        .padding(.horizontal, 32)
                }
                                    
                HStack {
                    Spacer()
                    
                    NavigationLink(
                        destination: Text("Reset Password.."),
                        label: {
                            Text("Forgot Password?")
                                .font(.system(size: 13, weight: .semibold))
                                .padding(.top)
                                .padding(.trailing, 28)
                        })
                }
                                    
                Button(action: {
                    viewModel.login(withEmail: email, password: password)
                }, label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding()
                })
                .shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
                
                Spacer()
                
                NavigationLink(
                    destination: RegistrationView().navigationBarBackButtonHidden(true),
                    label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 14))
                            
                            Text("Sign Up")
                                .font(.system(size: 14, weight: .semibold))
                        }.foregroundColor(.blue)
                    }).padding(.bottom, 16)
            }
            .padding(.top, -56)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
