//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

// Request body for refreshing a token
public struct RefreshTokenRequest: Encodable, Sendable {
    let grantType: String
    let refreshToken: String
}
