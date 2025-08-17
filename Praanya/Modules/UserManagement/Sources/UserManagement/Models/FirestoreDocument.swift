//
//  File.swift
//  UserManagement
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

// Helper structs to create a JSON body that conforms to the Firestore REST API format.
struct FirestoreDocument: Encodable {
    let fields: [String: FirestoreValue]
}

enum FirestoreValue: Encodable {
    case stringValue(String)
    case integerValue(String)
    case timestampValue(String)
    case arrayValue(FirestoreArray)
    case nullValue
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .stringValue(let value):
            try container.encode(["stringValue": value])
        case .integerValue(let value):
            try container.encode(["integerValue": value])
        case .timestampValue(let value):
            try container.encode(["timestampValue": value])
        case .arrayValue(let value):
            try container.encode(["arrayValue": value])
        case .nullValue:
            try container.encode(["nullValue": Optional<String>.none])
        }
    }
}

struct FirestoreArray: Encodable {
    let values: [FirestoreValue]
}
