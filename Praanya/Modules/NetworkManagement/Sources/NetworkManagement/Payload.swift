//
//  File.swift
//  UserManagement
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation

// Helper structs to create a JSON body that conforms to the Firestore REST API format.
public struct Payload: Encodable {
    let fields: [String: PayloadValue]
    
    public init(fields: [String : PayloadValue]) {
        self.fields = fields
    }
}

public enum PayloadValue: Encodable {
    case stringValue(String)
    case integerValue(Int)
    case doubleValue(Double)
    case booleanValue(Bool)
    case timestampValue(String)
    case arrayValue(PayloadArray)
    case nullValue
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .stringValue(let value):
            try container.encode(["stringValue": value])
        case .integerValue(let value):
            try container.encode(["integerValue": value])
        case .doubleValue(let value):
            try container.encode(["doubleValue": value])
        case .booleanValue(let value):
            try container.encode(["booleanValue": value])
        case .timestampValue(let value):
            try container.encode(["timestampValue": value])
        case .arrayValue(let value):
            try container.encode(["arrayValue": value])
        case .nullValue:
            try container.encode(["nullValue": Optional<String>.none])
        }
    }
}

public struct PayloadArray: Encodable {
    let values: [PayloadValue]
    
    public init(values: [PayloadValue]) {
        self.values = values
    }
}
