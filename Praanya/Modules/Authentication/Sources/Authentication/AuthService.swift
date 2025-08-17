// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import NetworkManagement // Import your networking module

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

    public init(networkService: NetworkServicing,
         config: AuthConfig) {
        self.networkService = networkService
        self.config = config
    }

    public func signUp(with details: AuthRequest) async throws -> AuthResponse {
            let endpoint = SignUpEndpoint(baseURL: config.authBaseURL, apiKey: config.apiKey, body: details)
            return try await networkService.request(endpoint: endpoint, as: AuthResponse.self)
        }

        public func signIn(with details: AuthRequest) async throws -> AuthResponse {
            let endpoint = SignInEndpoint(baseURL: config.authBaseURL, apiKey: config.apiKey, body: details)
            return try await networkService.request(endpoint: endpoint, as: AuthResponse.self)
        }

        public func forgotPassword(for email: String) async throws {
            let body = PasswordResetRequest(email: email)
            let endpoint = ForgotPasswordEndpoint(baseURL: config.authBaseURL, apiKey: config.apiKey, body: body)
            try await networkService.request(endpoint: endpoint)
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
