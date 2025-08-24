//
//  SwiftUIView.swift
//  UserManagement
//
//  Created by Manikanta Nandam on 24/08/25.
//

import SwiftUI

@MainActor
public class ProfileViewModel: ObservableObject {
    // @Published properties will notify the View of any changes.
    @Published var accountID: String = ""
    @Published var mobileNumber: String = ""
    @Published var fullName: String = ""
    @Published var emailAddress: String = ""

    private var user: User
    private let userService: UserService

    init(userService: UserService) {
        // Initialize with a default user and fetch data.
        self.userService = userService
        self.user = User(id: "", name: "", email: "", memberships: [], createdAt: Date(), updatedAt: Date(), status: .active, role: .view)
        fetchUserData()
    }

    // This function simulates fetching data from an API or database.
    func fetchUserData() {
        
        // Populate the user model with data from the screenshot.
        self.user = User(id: "12ds", name: "s", email: "s", memberships: [], createdAt: Date(), updatedAt: Date(), status: .active, role: .view)
        
        // Update the @Published properties to reflect the new data.
        self.accountID = user.id
        self.mobileNumber = user.phone ?? ""
        self.fullName = user.name
        self.emailAddress = user.email
    }
}

public struct UserView: View {
    // Create and observe an instance of the ViewModel.
    @ObservedObject private var viewModel: ProfileViewModel
    
    public init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            Form {
                Section {
                    // Account ID Field (disabled)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Account ID")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        TextField("Account ID", text: $viewModel.accountID)
                            .textFieldStyle(PlainTextFieldStyle())
                            .disabled(true) // Makes the field non-editable
                    }

                    // Mobile Number Field (custom view)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Mobile Number")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        PhoneNumberField(text: $viewModel.mobileNumber)
                    }

                    // Full Name Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your full name")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        TextField("Full name", text: $viewModel.fullName)
                            .textFieldStyle(PlainTextFieldStyle())
                    }

                    // Email Address Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email Address")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        TextField("Email Address", text: $viewModel.emailAddress)
                            .textFieldStyle(PlainTextFieldStyle())
//                            .keyboardType(.emailAddress)
//                            .autocapitalization(.none)
                    }
                }
            }
            .navigationTitle("Account Details")
        }
    }
}

struct PhoneNumberField: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: 0) {
            Text("+91")
                .font(.system(size: 16))
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
            
            #if os(iOS)
                .background(Color(.systemGray6))
            #else
                .background(Color(NSColor.controlBackgroundColor))
            #endif
                .foregroundColor(.gray)

            TextField("Mobile Number", text: $text)
                .padding(.leading, 12)
#if os(iOS)
                .keyboardType(.phonePad)
            #endif
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
#if os(iOS)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
#else
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(NSColor.controlBackgroundColor), lineWidth: 1)
        )
#endif
    }
}
