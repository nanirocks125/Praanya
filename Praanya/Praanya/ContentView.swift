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

    // 1. Create a single instance of the SessionManager and observe it.
    @StateObject private var sessionManager: SessionManager
    
    // 2. The AuthViewModel now also needs the SessionManager.
    @StateObject private var authViewModel: AuthViewModel

    init() {
        // Create the core dependencies
        let networkService = DefaultNetworkService()
        let authConfig = AuthConfig(
            apiKey: AppConfiguration.apiKey,
            authBaseURL: URL(string: "https://identitytoolkit.googleapis.com")!
        )
        
        // Initialize the SessionManager
        let sm = SessionManager(networkService: networkService, config: authConfig)
        _sessionManager = StateObject(wrappedValue: sm)

        // Initialize the AuthService with the SessionManager
        let authService = AuthService(networkService: networkService, config: authConfig, sessionManager: sm)
        
        // Initialize the AuthViewModel with both dependencies
        _authViewModel = StateObject(wrappedValue: AuthViewModel(authService: authService, sessionManager: sm))
    }

    var body: some View {
        // 3. The view now switches based on the SessionManager's state
        if sessionManager.currentSession != nil {
            // Show your main app content here
            VStack {
                Text("Welcome! You are logged in.")
                Text("User ID: \(sessionManager.currentSession!.uid)")
                Button("Sign Out") {
                    authViewModel.signOut()
                }
            }
        } else {
            // Show the authentication flow
            AuthenticationFlowView(viewModel: authViewModel) {
                Image("login-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}
