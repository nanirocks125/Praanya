// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
// MARK: - 4. Network Service Protocol
/// The public interface for our networking layer.
/// Other modules will depend on this protocol, not the concrete implementation.
public protocol NetworkServicing {
    /// Performs a network request and decodes the response.
    /// - Parameters:
    ///   - endpoint: The endpoint to be requested.
    ///   - type: The `Decodable` type to decode the response into.
    /// - Returns: An instance of the decoded type.
    /// - Throws: A `NetworkError` if the request fails.
    func request<T: Decodable>(endpoint: Endpoint, as type: T.Type) async throws -> T

    /// Performs a network request where no response body is expected.
    /// - Parameter endpoint: The endpoint to be requested.
    /// - Throws: A `NetworkError` if the request fails.
    func request(endpoint: Endpoint) async throws
}

// MARK: - 5. Default Network Service Implementation
/// The concrete implementation of `NetworkService` using `URLSession`.
public final class DefaultNetworkService: NetworkServicing {

    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func request<T: Decodable>(endpoint: Endpoint, as type: T.Type) async throws -> T {
        let (data, response) = try await performRequest(for: endpoint)
        
        do {
            let decoder = JSONDecoder()
            // Configure decoder if needed (e.g., date formatting)
            // decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }

    public func request(endpoint: Endpoint) async throws {
        _ = try await performRequest(for: endpoint)
    }

    // MARK: - Private Helper
    
    private func performRequest(for endpoint: Endpoint) async throws -> (Data, URLResponse) {
        // 1. Construct the URL
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        // 2. Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        // 3. Add Headers
        // Add common headers first
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Add endpoint-specific headers
        endpoint.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        // 4. Add Body
        if let body = endpoint.body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw NetworkError.encodingError(error)
            }
        }
        
        // 5. Perform the request
        let data, response: (Data, URLResponse)
        do {
            data = try await session.data(for: request)
            response = data
        } catch {
            throw NetworkError.requestFailed(error)
        }
        
        // 6. Validate the response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
        }
        
        return (data, response)
    }
}
