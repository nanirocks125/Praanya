//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import SwiftUI

// The view for signing up
public struct SignUpView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle).bold()
            
            AuthTextField(placeholder: "Email", text: $viewModel.email)
#if os(iOS)
                .keyboardType(.emailAddress)
#endif
            
            AuthSecureField(placeholder: "Password", text: $viewModel.password)
            AuthSecureField(placeholder: "Confirm Password", text: $viewModel.confirmPassword)
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                AuthButton(title: "Sign Up", action: viewModel.signUp)
            }
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}
