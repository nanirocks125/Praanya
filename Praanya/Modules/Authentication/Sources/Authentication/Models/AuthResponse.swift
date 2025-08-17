//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

// Response from a successful sign-in or sign-up
public struct AuthResponse: Decodable, Sendable {
    public let idToken: String
    public let email: String
    public let refreshToken: String
    public let expiresIn: String
    public let localId: String
}
