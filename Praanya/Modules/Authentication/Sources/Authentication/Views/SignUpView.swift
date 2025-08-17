import SwiftUI

public struct SignUpForm: View {
    @ObservedObject var viewModel: AuthViewModel
    @Binding var currentPage: AuthPage

    public var body: some View {
        AuthFormContainer(
            title: "CREATE ACCOUNT",
            subtitle: "Enter your details below to create an account",
            content: {
                StyledTextField(placeholder: "Email", text: $viewModel.email)
                StyledSecureField(placeholder: "Password", text: $viewModel.password)
                StyledSecureField(placeholder: "Confirm Password", text: $viewModel.confirmPassword)
                if viewModel.isLoading {
                    ProgressView().frame(height: 50)
                }
                else {
                    AuthActionButton(title: "Sign Up", action: viewModel.signUp)
                }
            },
            bottomLink: {
                HStack {
                    Text("Already have an account?").foregroundColor(.black)
                    Button("Log in") { currentPage = .login }
                        .buttonStyle(.plain)
                }.padding(.bottom, 20)
            }
        )
    }
}
