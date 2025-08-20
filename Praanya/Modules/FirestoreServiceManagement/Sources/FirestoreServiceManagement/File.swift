//
//  File.swift
//  FirestoreServiceManagement
//
//  Created by Manikanta Nandam on 20/08/25.
//

import Foundation

// A generic protocol for any model that can be converted to a Firestore document
protocol FirestoreConvertible: Codable {
    func toFirestoreDocument() -> FirestoreDocument
}

// A generic extension that provides a default implementation for the conversion
extension FirestoreConvertible {
    func toFirestoreDocument() -> FirestoreDocument {
        do {
            // Convert the Codable model into a dictionary
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            
            // Map the dictionary to Firestore-specific values
            let fields: [String: FirestoreValue] = dictionary.compactMapValues {
                // Handle different data types and return the correct Firestore Value
                if let stringValue = $0 as? String {
                    return .stringValue(stringValue)
                } else if let numberValue = $0 as? Double {
                    return .doubleValue(numberValue)
                } else if let intValue = $0 as? Int {
                    return .integerValue(Int(intValue))
                } else if let boolValue = $0 as? Bool {
                    return .booleanValue(boolValue)
                } else if let arrayValue = $0 as? [Any] {
                    // This is a simplified example; you would need a more robust recursive
                    // function to handle nested arrays of different types.
                    return .arrayValue(.init(values: arrayValue.map { .stringValue(String(describing: $0)) }))
                } else {
                    return .nullValue
                }
            }
            return FirestoreDocument(fields: fields)
        } catch {
            print("Error encoding model to Firestore document: \(error)")
            // Return a default document in case of failure
            return FirestoreDocument(fields: [:])
        }
    }
}
