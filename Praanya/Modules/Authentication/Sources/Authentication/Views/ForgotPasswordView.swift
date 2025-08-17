//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import SwiftUI

// The view for password reset
public struct ForgotPasswordView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("Reset Password")
                .font(.largeTitle).bold()
            
            Text("Enter your email address and we will send you a link to reset your password.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            AuthTextField(placeholder: "Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                AuthButton(title: "Send Reset Link", action: viewModel.forgotPassword)
            }
        }
        .padding()
        .navigationTitle("Forgot Password")
    }
}
