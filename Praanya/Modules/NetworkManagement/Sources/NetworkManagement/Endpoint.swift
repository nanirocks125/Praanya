//
//  File.swift
//  NetworkManagement
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

// MARK: - 3. Endpoint Protocol
/// A protocol to define the properties of a network endpoint.
/// Other modules will create structs conforming to this to define their specific API calls.
public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Encodable? { get }
}

public extension Endpoint {
    // Provide a default implementation for optional properties
    var headers: [String: String]? { nil }
    var body: Encodable? { nil }
    var queryItems: [URLQueryItem]? { nil }
}
