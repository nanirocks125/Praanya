//
//  ContentView.swift
//  Praanya
//
//  Created by Manikanta Nandam on 16/08/25.
//

import SwiftUI
import Authentication
import NetworkManagement
import SessionManagement
import UserManagement

struct ContentView: View {

    // 1. Create a single instance of the SessionManager and observe it.
    @StateObject private var sessionManager: SessionManager
    
    // 2. The AuthViewModel now also needs the SessionManager.
    @StateObject private var authViewModel: AuthViewModel
    
    @State var selectedTab: SidebarTab = .dashboard

    init() {
        // Create the core dependencies
        let networkService = DefaultNetworkService()
        let authConfig = AuthConfig(
            apiKey: AppConfiguration.apiKey,
            authBaseURL: URL(string: "https://identitytoolkit.googleapis.com")!
        )
        
        // Initialize the SessionManager
        let sm = SessionManager(networkService: networkService,
                                apiKey: AppConfiguration.apiKey)
        _sessionManager = StateObject(wrappedValue: sm)
        print("base url \(AppConfiguration.apiBaseURL)")
        let us = UserService(
            networkService: networkService,
            sessionManager: sm,
            firestoreBaseURL: AppConfiguration.apiBaseURL
        )

        // Initialize the AuthService with the SessionManager
        let authService = AuthService(
            networkService: networkService,
            config: authConfig,
            sessionManager: sm,
            userService: us
        )
        
        // Initialize the AuthViewModel with both dependencies
        _authViewModel = StateObject(wrappedValue: AuthViewModel(authService: authService, sessionManager: sm))
    }

    var body: some View {
        // 3. The view now switches based on the SessionManager's state
        if sessionManager.currentSession != nil {
            // Show your main app content here
            HeaderView()
            HStack {
                SidebarView(selectedTab: $selectedTab)
                switch selectedTab {
                case .settings:
                    SettingsView()
                default:
                    VStack {
                        Text("Welcome! You are logged in.")
                        Text("User ID: \(sessionManager.currentSession!.uid)")
                        Button("Sign Out") {
                            authViewModel.signOut()
                        }
                    }
                }
                Spacer()
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
