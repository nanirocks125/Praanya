//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import SwiftUI

// Add this import at the top of the file if it's not there.
// It's needed for NSColor on macOS.
#if os(macOS)
import AppKit
#endif

public struct AuthTextField: View {
    let placeholder: String
    @Binding var text: String

    public var body: some View {
        // We create the base TextField first
        let textField = TextField(placeholder, text: $text)
            .padding(12)
            .cornerRadius(10)
            .disableAutocorrection(true)

        // Now, we apply platform-specific modifiers
        #if os(iOS)
        // This code will ONLY be used when building for iOS
        textField
            .background(Color(.systemGray6))
            .autocapitalization(.none)
            .disableAutocorrection(true)
        #else
        // This code will ONLY be used when building for macOS
        textField
            // NSColor.windowBackgroundColor is a similar light gray for macOS
            .background(Color(NSColor.windowBackgroundColor))
        #endif
    }
}
