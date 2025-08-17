import SwiftUI

public struct SignUpForm: View {
    @ObservedObject var viewModel: AuthViewModel
    @Binding var currentPage: AuthPage

    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Text("CREATE ACCOUNT")
                .kerning(4)
                .font(.system(size: 32, weight: .light))
                .padding(.bottom, 35)
            Text("Enter your details below to create an account")
                .foregroundColor(Color(.systemGray))
                .font(.system(size: 14))
                .padding(.bottom, 25)
            VStack(spacing: 15) {
                StyledTextField(placeholder: "Email", text: $viewModel.email)
                StyledSecureField(placeholder: "Password", text: $viewModel.password)
                StyledSecureField(placeholder: "Confirm Password", text: $viewModel.confirmPassword)
            }.padding(.bottom, 25)
            
            if viewModel.isLoading { ProgressView().frame(height: 50) }
            else {
                AuthActionButton(title: "Sign Up", action: viewModel.signUp)
            }
            
            Spacer()
            HStack {
                Text("Already have an account?").foregroundColor(.black)
                Button("Log in") { currentPage = .login }
                    .buttonStyle(.plain)
            }.padding(.bottom, 20)
        }
        .padding(.horizontal, 50)
        .frame(maxWidth: 420)
        .background(Color.white)
    }
}
