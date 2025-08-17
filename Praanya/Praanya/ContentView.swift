//
//  ContentView.swift
//  Praanya
//
//  Created by Manikanta Nandam on 16/08/25.
//

import SwiftUI
import Authentication
import NetworkManagement

struct ContentView: View {

    // 1. Create the services and view model
    // This is where you inject your dependencies
    private var authViewModel: AuthViewModel = {
        let networkService = DefaultNetworkService()
        let authConfig = AuthConfig(
            apiKey: AppConfiguration.apiKey,
            authBaseURL: URL(string: "https://identitytoolkit.googleapis.com")!
        )
        let authService = AuthService(networkService: networkService, config: authConfig)
        return AuthViewModel(authService: authService)
    }()

    var body: some View {
        // 2. Check the view model's state to decide what to show
        if authViewModel.userIsLoggedIn {
            // Show your main app content here
            Text("Welcome to the Main App!")
        } else {
            // Show the authentication flow
            AuthenticationView(viewModel: authViewModel)
        }
    }
}

#Preview {
    ContentView()
}
