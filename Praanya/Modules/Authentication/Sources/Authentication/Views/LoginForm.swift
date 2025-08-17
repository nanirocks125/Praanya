import SwiftUI

#if os(macOS)
import AppKit
#endif

public struct LoginForm: View {
    @ObservedObject var viewModel: AuthViewModel
    @Binding var currentPage: AuthPage // Binding to control the page state

    public var body: some View {
        AuthFormContainer(
            title: "PRAANYA",
            subtitle: "Log in below or sign up to create an account",
            content: {
                HStack(spacing: 15) {
                    SocialLoginButton(iconName: "g.circle.fill", text: "Google")
                    SocialLoginButton(iconName: "f.circle.fill", text: "Facebook")
                }.padding(.bottom, 25)
                HStack(spacing: 15) {
                    DividerLine(); Text("or").foregroundColor(Color(.systemGray)); DividerLine()
                }.padding(.bottom, 25)
                VStack(spacing: 15) {
                    StyledTextField(placeholder: "Username or email", text: $viewModel.email)
                    StyledSecureField(placeholder: "Password", text: $viewModel.password)
                }.padding(.bottom, 25)
                
                if viewModel.isLoading { ProgressView().frame(height: 50) }
                else {
                    AuthActionButton(title: "Log in", action: viewModel.signIn)
                }
                Button("Forgot password?") { currentPage = .forgotPassword }
                    .buttonStyle(.plain)
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray))
                    .padding(.top, 15)
            },
            bottomLink: {
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.black)
                    Button("Sign up") {
                        currentPage = .signUp
                    }
                    .buttonStyle(.plain)
                }.padding(.bottom, 20)
            }
        )
    }
}
