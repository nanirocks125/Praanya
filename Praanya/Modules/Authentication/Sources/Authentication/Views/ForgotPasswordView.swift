import SwiftUI


public struct ForgotPasswordForm: View {
    @ObservedObject var viewModel: AuthViewModel
    @Binding var currentPage: AuthPage

    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Text("RESET PASSWORD").kerning(4).font(.system(size: 32, weight: .light))
                .padding(.bottom, 35)
            Text("Enter your email to receive a password reset link").foregroundColor(Color(.systemGray)).font(.system(size: 14)).multilineTextAlignment(.center)
                .padding(.bottom, 25)
            VStack(spacing: 15) {
                StyledTextField(placeholder: "Email", text: $viewModel.email)
            }.padding(.bottom, 25)
            
            if viewModel.isLoading { ProgressView().frame(height: 50) }
            else {
                AuthActionButton(title: "Send Reset Link", action: viewModel.forgotPassword)
            }
            
            Spacer()
            HStack {
                Text("Remember your password?").foregroundColor(.black)
                Button("Log in") { currentPage = .login }
                    .buttonStyle(.plain)
            }.padding(.bottom, 20)
        }
        .padding(.horizontal, 50).frame(maxWidth: 420).background(Color.white)
    }
}
