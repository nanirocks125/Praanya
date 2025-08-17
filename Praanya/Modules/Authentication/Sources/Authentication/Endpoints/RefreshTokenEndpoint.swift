//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation
import NetworkManagement

struct RefreshTokenEndpoint: Endpoint {
    let apiKey: String
    var body: Encodable?
    
    // Note: The base URL for token refresh is different from the auth URL
    var baseURL: URL { URL(string: "https://securetoken.googleapis.com/v1")! }
    var path: String { "/token" }
    var method: HTTPMethod { .post }
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "key", value: apiKey)]
    }
}
