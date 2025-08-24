//
//  File.swift
//  Utilities
//
//  Created by Manikanta Nandam on 24/08/25.
//

import SwiftUI

// MARK: - Helpers

// A centralized place for the app's color palette.
public extension Color {
    static let appBackground = Color(red: 247/255, green: 248/255, blue: 250/255)
    static let primaryText = Color(red: 51/255, green: 51/255, blue: 51/255)
    static let secondaryText = Color.gray
    static let accentColor = Color(red: 32/255, green: 191/255, blue: 168/255)

    // Status Colors
    static let goodStatusBackground = Color(red: 230/255, green: 247/255, blue: 237/255)
    static let goodStatusForeground = Color(red: 20/255, green: 139/255, blue: 82/255)
    
    static let lowStockStatusBackground = Color(red: 255/255, green: 244/255, blue: 229/255)
    static let lowStockStatusForeground = Color(red: 217/255, green: 119/255, blue: 6/255)

    static let outOfStockStatusBackground = Color(red: 242/255, green: 242/255, blue: 242/255)
    static let outOfStockStatusForeground = Color(red: 102/255, green: 102/255, blue: 102/255)

    static let expiredStatusBackground = Color(red: 254/255, green: 226/255, blue: 226/255)
    static let expiredStatusForeground = Color(red: 185/255, green: 28/255, blue: 28/255)
}
