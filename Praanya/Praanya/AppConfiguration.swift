//
//  AppConfiguration.swift
//  Praanya
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

/// A helper to safely read configuration values from the app's Info.plist.
enum AppConfiguration {
    
    /// Reads a value from the bundle's Info.plist.
    /// - Parameter key: The key for the value to retrieve.
    /// - Returns: The configured value.
    private static func value<T>(for key: String) -> T {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? T else {
            fatalError("Error: Missing or invalid key in Info.plist: \(key)")
        }
        return value
    }
    
    /// The base URL for the backend API, loaded from the active .xcconfig file.
    static var apiBaseURL: URL {
        let apiBaseURL = "https://\(value(for: "ApiBaseURL") as String)"
        return URL(string: apiBaseURL)!
    }
    
    /// The API key for the backend service, loaded from the active .xcconfig file.
    static var apiKey: String {
        return value(for: "ApiKey")
    }
}
