//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

// Request body for signing up or signing in
public struct AuthRequest: Encodable, Sendable {
    let email: String
    let password: String
    let returnSecureToken: Bool = true
}
