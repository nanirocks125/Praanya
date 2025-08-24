//
//  MainView.swift
//  Praanya
//
//  Created by Manikanta Nandam on 23/08/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        // Show your main app content here
        VStack {
            Text("Welcome! You are logged in.")
//            Text("User ID: \(sessionManager.currentSession!.uid)")
//            Button("Sign Out") {
//                authViewModel.signOut()
//            }
        }
    }
}

#Preview {
    MainView()
}
