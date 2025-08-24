//
//  SummaryCardView.swift
//  Praanya
//
//  Created by Manikanta Nandam on 24/08/25.
//

import SwiftUI

struct SummaryCardView: View {
    let title: String
    let value: String
    let description: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color.opacity(1)) // Opaque icon color
                .padding(12)
                .background(color)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.secondaryText)
                Text(value)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primaryText)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondaryText)
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
    }
}
