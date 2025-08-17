//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import SwiftUI

// The SwiftUI views for the UI.

// This is the main view the app will present.
// It handles navigation between the different auth screens.
public struct AuthenticationView: View {
    @StateObject public var viewModel: AuthViewModel
    
    public init(viewModel: AuthViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationView {
            SignInView(viewModel: viewModel)
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(title: Text("Authentication"), message: Text(viewModel.alertMessage ?? "An error occurred."), dismissButton: .default(Text("OK")))
        }
    }
}
