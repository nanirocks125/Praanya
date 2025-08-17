//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import SwiftUI

// MARK: - Reusable UI Components

public struct AuthTextField: View {
    let placeholder: String
    @Binding var text: String
    
    public var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}
