//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import SwiftUI

public struct AuthFormContainer<Content: View, BottomLink: View>: View {
    let title: String
    let subtitle: String
    @ViewBuilder let content: Content
    @ViewBuilder let bottomLink: BottomLink

    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Text(title).kerning(4).font(.system(size: 32, weight: .light))
                .padding(.bottom, 35)
            Text(subtitle).foregroundColor(Color(.systemGray)).font(.system(size: 14))
                .padding(.bottom, 25)
            
            content // <-- The unique part of each form goes here
            
            Spacer()
            
            bottomLink // <-- The unique bottom link goes here
                .padding(.bottom, 20)
        }
        .padding(.horizontal, 50)
        .frame(maxWidth: 420)
        .background(Color.white)
    }
}
