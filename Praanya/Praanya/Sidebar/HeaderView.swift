//
//  HeaderView.swift
//  Praanya
//
//  Created by Manikanta Nandam on 24/08/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Inventory Management")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primaryText)
                Text("Today, August 16th 2024")
                    .font(.subheadline)
                    .foregroundColor(.secondaryText)
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondaryText)
                    Text("Search").foregroundColor(.secondaryText)
                    Spacer()
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
                .frame(width: 250)

                Image(systemName: "bell")
                    .font(.title2)
                    .foregroundColor(.primaryText)
                
                HStack {
                    Image("profile_pic") // Ensure you have this image in your assets
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    Text("Sam Sam")
                        .fontWeight(.semibold)
                        .foregroundColor(.primaryText)
                    Image(systemName: "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                }
            }
        }
    }
}
