//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import SwiftUI

public struct DividerLine: View {
    
    public var body: some View {
#if os(iOS)
        return Rectangle().frame(height: 1).foregroundColor(Color(.systemGray5))
#else
        return Rectangle().frame(height: 1).foregroundColor(Color(NSColor.gridColor))
#endif
    }
}
