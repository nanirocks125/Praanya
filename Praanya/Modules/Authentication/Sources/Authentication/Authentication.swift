// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import NetworkManagement // Import your networking module

// 1. Define the specific endpoint
struct LoginEndpoint: Endpoint {
    var baseURL: URL = URL(string: "https://identitytoolkit.googleapis.com/v1")! // Firebase Auth URL
    var path: String = "/accounts:signInWithPassword"
    var method: HTTPMethod = .post
    var body: Encodable?

    init(apiKey: String, body: LoginRequestBody) {
        // Firebase Auth REST API requires the API key as a query parameter
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
class AuthService {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func login(apiKey: String, credentials: LoginRequestBody) async throws -> LoginResponse {
        let endpoint = LoginEndpoint(apiKey: apiKey, body: credentials)
        return try await networkService.request(endpoint: endpoint, as: LoginResponse.self)
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
