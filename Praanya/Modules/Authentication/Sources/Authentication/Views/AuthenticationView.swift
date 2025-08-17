//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import SwiftUI

// The SwiftUI views for the UI.

// This is the main view the app will present.
// It handles navigation between the different auth screens.
public struct AuthenticationView: View {
    @StateObject public var viewModel: AuthViewModel
    
    public init(viewModel: AuthViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack {
            SignInView(viewModel: viewModel) {
                Color.gray
//                Image("login-background") // <-- This is the configurable part
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .overlay(Color.black.opacity(0.2)) // Optional: add an overlay
            }
        }
        .navigationDestination(for: String.self) { route in
                        switch route {
                        case "SignUp":
                            SignUpView(viewModel: viewModel)
                        case "ForgotPassword":
                            ForgotPasswordView(viewModel: viewModel)
                        default:
                            EmptyView()
                        }
                    }
        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(title: Text("Authentication"), message: Text(viewModel.alertMessage ?? "An error occurred."), dismissButton: .default(Text("OK")))
        }
    }
}
