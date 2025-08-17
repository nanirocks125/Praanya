//
//  File.swift
//  NetworkManagement
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

// MARK: - 1. Network Error
/// A comprehensive enum to represent various networking errors.
public enum NetworkError: Error, Equatable {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case httpError(statusCode: Int, data: Data?)
    case decodingError(Error)
    case encodingError(Error)
    case unknown

    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The provided URL is invalid."
        case .requestFailed(let error):
            return "The network request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "The server returned an invalid response."
        case .httpError(let statusCode, _):
            return "An HTTP error occurred with status code: \(statusCode)."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .encodingError(let error):
            return "Failed to encode the request body: \(error.localizedDescription)"
        case .unknown:
            return "An unknown networking error occurred."
        }
    }
}

// MARK: - 2. HTTP Method
/// A type-safe enum for HTTP request methods.
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
