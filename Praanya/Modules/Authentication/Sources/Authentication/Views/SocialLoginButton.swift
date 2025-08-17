//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import SwiftUI

// MARK: - Reusable UI Components (Cross-Platform)

public struct SocialLoginButton: View {
    let iconName: String
    let text: String
    
    public var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: iconName)
                    .font(.system(size: 20))
                Text(text)
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    #if os(iOS)
                    .stroke(Color(.systemGray4))
                    #else
                    .stroke(Color(NSColor.separatorColor))
                    #endif
            )
        }
        .buttonStyle(.plain)
    }
}
