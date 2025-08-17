// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import NetworkManagement
import SessionManagement
import UserManagement

// 1. Define the specific endpoint
struct LoginEndpoint: Endpoint {
//    var baseURL: URL = URL(string: "https://identitytoolkit.googleapis.com/v1")! // Firebase Auth URL
    var baseURL: URL
    var path: String = "/accounts:signInWithPassword"
    var method: HTTPMethod = .post
    var body: Encodable?

    init(baseURL: URL, apiKey: String, body: LoginRequestBody) {
        // Firebase Auth REST API requires the API key as a query parameter
        self.baseURL = baseURL
        self.path += "?key=\(apiKey)"
        self.body = body
    }
}

struct LoginRequestBody: Encodable {
    let email: String
    let password: String
    let returnSecureToken: Bool = true
}

// 2. Use the NetworkService to make the call
public final class AuthService: Sendable {
    private let networkService: NetworkServicing
    private let config: AuthConfig
    private let sessionManager: SessionManager // <-- Add dependency
    private let userService: UserService

    public init(
        networkService: NetworkServicing,
        config: AuthConfig,
        sessionManager: SessionManager,
        userService: UserService
    ) {
        self.networkService = networkService
        self.config = config
        self.sessionManager = sessionManager
    }

    public func signUp(with details: AuthRequest) async throws {
            // 1. First, create the user in Firebase Authentication
            let endpoint = SignUpEndpoint(baseURL: config.authBaseURL, apiKey: config.apiKey, body: details)
            let response = try await networkService.request(endpoint: endpoint, as: AuthResponse.self)
            
            // 2. Create the session for the newly created user
            let session = UserSession(
                uid: response.localId,
                idToken: response.idToken,
                refreshToken: response.refreshToken,
                expiresIn: TimeInterval(response.expiresIn) ?? 3600,
                createdAt: Date()
            )
            await sessionManager.saveSession(session)
            
            // 3. Now, create the corresponding user document in Firestore
            // CORRECTED: The User object now exactly matches the model in the repository.
            let newUser = User(
                id: response.localId,
                name: "New User", // Default name, can be updated later
                email: response.email,
                phone: nil,
                imageURL: nil,
                organizationMemberships: [],
                createdAt: Date(),
                updatedAt: Date(),
                status: .active
            )
            
            try await userService.createUser(newUser)
        }

    public func signIn(with details: AuthRequest) async throws {
            let endpoint = SignInEndpoint(baseURL: config.authBaseURL, apiKey: config.apiKey, body: details)
            let response = try await networkService.request(endpoint: endpoint, as: AuthResponse.self)
            
            // After successful signin, create and save the session
            let session = UserSession(
                uid: response.localId,
                idToken: response.idToken,
                refreshToken: response.refreshToken,
                expiresIn: TimeInterval(response.expiresIn) ?? 3600,
                createdAt: Date()
            )
            await sessionManager.saveSession(session)
        }

    public func forgotPassword(for email: String) async throws {
        let body = PasswordResetRequest(email: email)
        let endpoint = ForgotPasswordEndpoint(baseURL: config.authBaseURL, apiKey: config.apiKey, body: body)
        try await networkService.request(endpoint: endpoint)
    }
    
    public func signOut() async {
        await sessionManager.signOut()
    }
}

// Define your expected response model
struct LoginResponse: Decodable {
    let idToken: String
    let email: String
    let refreshToken: String
    let expiresIn: String
    let localId: String
}
