//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import SwiftUI

// The view for signing in
public struct SignInView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("Welcome Back")
                .font(.largeTitle).bold()
            
            AuthTextField(placeholder: "Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
            
            AuthSecureField(placeholder: "Password", text: $viewModel.password)
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                AuthButton(title: "Sign In", action: viewModel.signIn)
            }
            
            NavigationLink("Create Account", destination: SignUpView(viewModel: viewModel))
            NavigationLink("Forgot Password?", destination: ForgotPasswordView(viewModel: viewModel))
        }
        .padding()
        .navigationTitle("Sign In")
    }
}
