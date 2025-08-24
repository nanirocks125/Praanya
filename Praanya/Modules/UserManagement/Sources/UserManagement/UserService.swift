// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import NetworkManagement
import SessionManagement

/// A service dedicated to managing user data in Firestore.
public final class UserService: Sendable {
    private let networkService: NetworkServicing // CORRECTED
    private let sessionManager: SessionManager // To get the authenticated user's token
    private let firestoreBaseURL: URL

    public init(networkService: NetworkServicing, sessionManager: SessionManager, firestoreBaseURL: URL) { // CORRECTED
        self.networkService = networkService
        self.sessionManager = sessionManager
        self.firestoreBaseURL = firestoreBaseURL
    }
    
    /// Creates a new user document in the 'users' collection in Firestore.
    /// - Parameter user: The User object to be created.
    public func createUser(_ user: User) async throws {
        // Get a valid ID token to authenticate the request
        let idToken = try await sessionManager.getValidIdToken()
        
        let endpoint = CreateUserEndpoint(
            baseURL: firestoreBaseURL,
            token: idToken,
            user: user
        )
        print("Final end point url is \(endpoint)")
        // We don't need to decode a response, just ensure the request succeeds.
        try await networkService.request(endpoint: endpoint)
        print("Successfully created user document for UID: \(user.id)")
    }
    
    public func fetchUser(_ userID: String) async throws {
        // Get a valid ID token to authenticate the request
        guard
            let userID = await sessionManager.currentSession?.uid
        else { return }
        
        let idToken = try await sessionManager.getValidIdToken()
        
        let endpoint = FetchUserEndpoint(
            baseURL: firestoreBaseURL,
            token: idToken,
            userID: userID
        )
        print("Final end point url is \(endpoint)")
        // We don't need to decode a response, just ensure the request succeeds.
        try await networkService.request(endpoint: endpoint)
        print("Successfully created user document for UID: \(userID)")
    }
}
