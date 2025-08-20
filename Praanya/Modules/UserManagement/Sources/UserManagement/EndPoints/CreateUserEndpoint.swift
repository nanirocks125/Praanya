//
//  File.swift
//  UserManagement
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation
import NetworkManagement

/// Endpoint for creating a user document in Firestore.
/// The document ID will be the user's UID.
struct CreateUserEndpoint: Endpoint {
    let baseURL: URL
    let token: String
    let user: User
    
    var path: String { "/users/\(user.id)" }
    
    var method: HTTPMethod { .patch }
    
    var headers: [String : String]? {
        ["Authorization": "Bearer \(token)"]
    }
    
    var body: Encodable? {
//        let now = ISO8601DateFormatter().string(from: Date())
        
        // CORRECTED: The fields now exactly match the User model in the repository.
        return user.toFirestoreDocument()
    }
}
