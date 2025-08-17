//
//  PraanyaApp.swift
//  Praanya
//
//  Created by Manikanta Nandam on 16/08/25.
//

import SwiftUI
import Authentication
import NetworkManagement

// 1. Create an instance of the network service
//let networkService = DefaultNetworkService()
//
//// 2. Create the configuration by reading from your .xcconfig files
//let authConfig = AuthConfig(
//    apiKey: AppConfiguration.apiKey, // Reads from Info.plist
//    authBaseURL: URL(string: "https://identitytoolkit.googleapis.com/v1")! // Or another URL from your config
//)
//
//// 3. Inject both dependencies into the AuthService
//let authService = AuthService(
//    networkService: networkService,
//    config: authConfig,
//    sessionManager: <#T##SessionManager#>
//)

// Now you can use the authService, which is fully configured
// and completely unaware of where the configuration came from.
@main
struct PraanyaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
