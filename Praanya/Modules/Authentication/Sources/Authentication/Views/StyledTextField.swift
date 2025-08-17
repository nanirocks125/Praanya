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

public struct StyledTextField: View {
    let placeholder: String
    @Binding var text: String
    
    public var body: some View {
        let field = TextField(placeholder, text: $text)
            .font(.system(size: 14))
            .padding(.horizontal, 15)
            .frame(height: 50)
            .cornerRadius(10)
            .textFieldStyle(.plain)
            .disableAutocorrection(true)

        #if os(iOS)
        field
            .background(Color(.systemGray6))
            .autocapitalization(.none)
        #else
        field
            .background(Color(NSColor.controlBackgroundColor))
        #endif
    }
}
