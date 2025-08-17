//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

struct SignInEndpoint: Endpoint {
    let baseURL: URL
    let apiKey: String
    var body: Encodable?

    init(baseURL: URL, apiKey: String, body: AuthRequest) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.body = body
    }

    var path: String { "/v1/accounts:signInWithPassword?key=\(apiKey)" }
    var method: HTTPMethod { .post }
}
