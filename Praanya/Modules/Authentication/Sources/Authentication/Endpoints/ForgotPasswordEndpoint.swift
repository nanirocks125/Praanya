//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation
import NetworkManagement

struct ForgotPasswordEndpoint: Endpoint {
    let baseURL: URL
    let apiKey: String
    var body: Encodable?

    init(baseURL: URL, apiKey: String, body: PasswordResetRequest) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.body = body
    }

    var path: String { "/v1/accounts:sendOobCode?key=\(apiKey)" }
    var method: HTTPMethod { .post }
}
