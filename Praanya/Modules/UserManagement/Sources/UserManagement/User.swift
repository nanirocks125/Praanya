//
//  File.swift
//  UserManagement
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation
import NetworkManagement

// This would live in your UserManagement package, likely in a Models folder.
public struct User: HttpCodable, Identifiable {
    // Existing Properties
    public let id: String // Corresponds to the Firebase Auth UID
    public var name: String
    public var email: String
    public var phone: String?
    public var imageURL: String?
    public var memberships: [String] // Array of organization IDs

    // --- Suggested New Properties ---

    // Timestamps for auditing
    public let createdAt: Date
    public var updatedAt: Date
    public var lastLoginAt: Date?

    // Account status
    public var status: UserStatus

    // You would use CodingKeys if your Firestore field names
    // are different from your struct property names.
    public init(id: String, name: String, email: String, phone: String? = nil, imageURL: String? = nil, memberships: [String], createdAt: Date, updatedAt: Date, lastLoginAt: Date? = nil, status: UserStatus) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.imageURL = imageURL
        self.memberships = memberships
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.lastLoginAt = lastLoginAt
        self.status = status
    }
}

public enum UserStatus: String, Codable {
    case active
    case inactive
    case suspended
}
