//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import SwiftUI

// Add this import at the top of the file if it's not there.
#if os(macOS)
import AppKit
#endif

public struct AuthSecureField: View {
    let placeholder: String
    @Binding var text: String

    public var body: some View {
        let secureField = SecureField(placeholder, text: $text)
            .padding()
            .cornerRadius(10)

        #if os(iOS)
        // This code is for iOS
        secureField
            .background(Color(.systemGray6))
        #else
        // This code is for macOS
        secureField
            .background(Color(NSColor.windowBackgroundColor))
        #endif
    }
}
