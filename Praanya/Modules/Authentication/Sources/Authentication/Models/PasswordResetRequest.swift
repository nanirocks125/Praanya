//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

// Request body for password reset
public struct PasswordResetRequest: Encodable, Sendable {
    let requestType: String = "PASSWORD_RESET"
    let email: String
}
