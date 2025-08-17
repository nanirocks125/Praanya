//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

// Response from a successful token refresh
public struct RefreshTokenResponse: Decodable, Sendable {
    let expiresIn: String
    let tokenType: String
    let refreshToken: String
    let idToken: String
    let userId: String

    // Map snake_case keys from Firebase to camelCase
    enum CodingKeys: String, CodingKey {
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case idToken = "id_token"
        case userId = "user_id"
    }
}
