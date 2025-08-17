//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

public struct AuthConfig: Sendable {
    public let apiKey: String
    public let authBaseURL: URL

    public init(apiKey: String, authBaseURL: URL) {
        self.apiKey = apiKey
        self.authBaseURL = authBaseURL
    }
}
