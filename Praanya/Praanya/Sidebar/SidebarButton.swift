//
//  SidebarButton.swift
//  Praanya
//
//  Created by Manikanta Nandam on 24/08/25.
//

import SwiftUI

struct SidebarButton: View {
    let icon: String
    let title: String
    let tab: SidebarTab
    @Binding var selectedTab: SidebarTab
    
    var isSelected: Bool {
        tab == selectedTab
    }

    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(isSelected ? Color.accentColor.opacity(0.1) : Color.clear)
            .foregroundColor(isSelected ? .accentColor : .gray)
            .cornerRadius(10)
            .padding(.horizontal, 10)
    }
    .buttonStyle(PlainButtonStyle())
  }
}
