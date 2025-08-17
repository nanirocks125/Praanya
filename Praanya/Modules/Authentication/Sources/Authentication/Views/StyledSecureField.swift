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

public struct StyledSecureField: View {
    let placeholder: String
    @Binding var text: String
    
    public var body: some View {
        let field = SecureField(placeholder, text: $text)
            .font(.system(size: 14))
            .padding(.horizontal, 15)
            .frame(height: 50)
            .cornerRadius(10)
            .textFieldStyle(.plain)
        
        #if os(iOS)
        field
            .background(Color(.systemGray6))
        #else
        field
            .background(Color(NSColor.controlBackgroundColor))
        #endif
    }
}
