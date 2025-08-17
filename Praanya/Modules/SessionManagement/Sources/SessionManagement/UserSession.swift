//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

/// A model to hold the user's session data, including tokens and user ID.
/// Codable conformance allows it to be easily saved to and loaded from the Keychain.
public struct UserSession: Codable, Sendable {
    public let uid: String
    public let idToken: String
    public let refreshToken: String
    public let expiresIn: TimeInterval // Store as TimeInterval for easier date calculations
    public let createdAt: Date
    
    public init(uid: String, idToken: String, refreshToken: String, expiresIn: TimeInterval, createdAt: Date) {
        self.uid = uid
        self.idToken = idToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
        self.createdAt = createdAt
    }
    
    /// Calculated property to determine if the ID token has expired.
    public var isExpired: Bool {
        // Add a 60-second buffer to be safe
        return Date() > createdAt.addingTimeInterval(expiresIn - 60)
    }
}
