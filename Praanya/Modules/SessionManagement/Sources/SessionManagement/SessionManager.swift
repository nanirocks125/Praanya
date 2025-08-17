//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation
import Security // Required for Keychain access
import NetworkManagement

// MARK: - Custom Auth Errors
public enum AuthError: Error {
    case noActiveSession
    case sessionExpired
}

/// Manages the user's session, including secure storage and token refreshing.
@MainActor
public final class SessionManager: ObservableObject, Sendable {
    
    /// The currently active user session. The UI will react to changes to this property.
    @Published public private(set) var currentSession: UserSession?
    
    // Dependencies
    private let networkService: NetworkServicing
    private let config: AuthConfig
    
    // Keychain configuration
    private let keychainService = "com.praanya.auth"
    private let keychainAccount = "userSession"

    public init(networkService: NetworkServicing, config: AuthConfig) {
        self.networkService = networkService
        self.config = config
        // Attempt to load a session from the Keychain upon initialization
        self.currentSession = loadSessionFromKeychain()
    }
    
    /// Saves the user session to the Keychain after a successful login/signup.
    public func saveSession(_ session: UserSession) {
        self.currentSession = session
        saveSessionToKeychain(session)
    }
    
    /// Removes the user session from the app and the Keychain.
    public func signOut() {
        self.currentSession = nil
        deleteSessionFromKeychain()
    }
    
    /// Returns a valid ID token, refreshing it if it's expired.
    public func getValidIdToken() async throws -> String {
        guard let session = currentSession else {
            throw AuthError.noActiveSession
        }
        
        if session.isExpired {
            try await refreshSession()
        }
        
        // At this point, currentSession is guaranteed to be non-nil and have a valid token
        return currentSession!.idToken
    }
    
    // MARK: - Private Token Refresh Logic
    
    private func refreshSession() async throws {
        guard let session = currentSession else {
            throw AuthError.noActiveSession
        }
        
        let request = RefreshTokenRequest(grantType: "refresh_token", refreshToken: session.refreshToken)
        let endpoint = RefreshTokenEndpoint(apiKey: config.apiKey, body: request)
        
        do {
            let response = try await networkService.request(endpoint: endpoint, as: RefreshTokenResponse.self)
            
            // Create a new session with the refreshed tokens
            let newSession = UserSession(
                uid: response.userId,
                idToken: response.idToken,
                refreshToken: response.refreshToken,
                expiresIn: TimeInterval(response.expiresIn) ?? 3600,
                createdAt: Date() // Reset the creation date
            )
            saveSession(newSession)
            print("Successfully refreshed token.")
        } catch {
            print("Failed to refresh token: \(error). Signing out.")
            // If refresh fails, the user must log in again.
            signOut()
            throw AuthError.sessionExpired
        }
    }
    
    // MARK: - Private Keychain Logic
    
    private func saveSessionToKeychain(_ session: UserSession) {
        do {
            let data = try JSONEncoder().encode(session)
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: keychainService,
                kSecAttrAccount as String: keychainAccount,
                kSecValueData as String: data
            ]
            
            // Delete any existing item before saving
            SecItemDelete(query as CFDictionary)
            
            // Add the new item
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {
                print("Error saving session to Keychain: \(status)")
                return
            }
            print("Session saved to Keychain.")
        } catch {
            print("Failed to encode session for Keychain: \(error)")
        }
    }
    
    private func loadSessionFromKeychain() -> UserSession? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: keychainAccount,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let data = dataTypeRef as? Data else {
            print("No session found in Keychain or error fetching: \(status)")
            return nil
        }
        
        do {
            let session = try JSONDecoder().decode(UserSession.self, from: data)
            print("Session loaded from Keychain.")
            return session
        } catch {
            print("Failed to decode session from Keychain: \(error)")
            // If decoding fails, the data is corrupt, so delete it.
            deleteSessionFromKeychain()
            return nil
        }
    }
    
    private func deleteSessionFromKeychain() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: keychainAccount
        ]
        SecItemDelete(query as CFDictionary)
        print("Session deleted from Keychain.")
    }
}
