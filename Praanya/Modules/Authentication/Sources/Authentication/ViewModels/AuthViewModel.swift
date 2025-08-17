//
//  File.swift
//  Authentication
//
//  Created by Manikanta Nandam on 17/08/25.
//

import Foundation
import SessionManagement

// Manages the state and logic for the authentication views.

@MainActor
public class AuthViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published public var email = "nanirocks125@gmail.com"
    @Published public var password = "Nandam@125"
    @Published public var confirmPassword = "Nandam@125"
    
    @Published public var isLoading = false
    @Published public var alertMessage: String?
    @Published public var isShowingAlert = false
    
    // MARK: - Dependencies
    private let authService: AuthService
    private let sessionManager: SessionManager

    // MARK: - Public State
    // The main app can observe this to know when login is successful.
    @Published public var userIsLoggedIn = false
    
    public init(
        authService: AuthService,
        sessionManager: SessionManager
    ) {
        self.authService = authService
        self.sessionManager = sessionManager
    }
    
    // MARK: - Public Methods
    
    public func signUp() {
        print("Signing up")
        guard validateSignUp() else { return }
        
        performAuthAction { [weak self] in
            guard let self = self else { return }
            let request = AuthRequest(email: self.email, password: self.password)
            let _ = try await self.authService.signUp(with: request)
            self.handleSuccess(message: "Sign up successful! Please sign in.")
        }
    }
    
    public func signIn() {
        print("Signing in")
        guard validateSignIn() else { return }
        
        performAuthAction { [weak self] in
            guard let self = self else { return }
            let request = AuthRequest(email: self.email, password: self.password)
            let _ = try await self.authService.signIn(with: request)
            self.userIsLoggedIn = true // Notify the app of successful login
            print("Successful sign in")
        }
    }
    
    public func forgotPassword() {
        guard !email.isEmpty else {
            handleError(message: "Please enter your email address.")
            return
        }
        
        performAuthAction { [weak self] in
            guard let self = self else { return }
            try await self.authService.forgotPassword(for: self.email)
            self.handleSuccess(message: "A password reset link has been sent to your email.")
        }
    }
    
    public func signOut() {
        Task {
            await authService.signOut()
        }
    }
    
    // MARK: - Private Helpers
    
    private func performAuthAction(_ action: @escaping () async throws -> Void) {
        isLoading = true
        Task {
            do {
                try await action()
            } catch {
                print("Error while sign up \(error)")
                handleError(message: error.localizedDescription)
            }
            isLoading = false
        }
    }
    
    private func validateSignUp() -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            handleError(message: "Email and password cannot be empty.")
            return false
        }
        guard password == confirmPassword else {
            handleError(message: "Passwords do not match.")
            return false
        }
        return true
    }
    
    private func validateSignIn() -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            handleError(message: "Email and password cannot be empty.")
            return false
        }
        return true
    }
    
    private func handleError(message: String) {
        alertMessage = message
        isShowingAlert = true
    }
    
    private func handleSuccess(message: String) {
        alertMessage = message
        isShowingAlert = true
        // Optionally clear fields on success
        email = ""
        password = ""
        confirmPassword = ""
    }
}
