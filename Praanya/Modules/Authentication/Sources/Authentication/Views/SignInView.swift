import SwiftUI

#if os(macOS)
import AppKit
#endif

// MARK: - Main Public Login View
public struct SignInView<ImageView: View>: View {
    @ObservedObject var viewModel: AuthViewModel
    let imageView: () -> ImageView
    
    public init(viewModel: AuthViewModel, @ViewBuilder imageView: @escaping () -> ImageView) {
        self.viewModel = viewModel
        self.imageView = imageView
    }
    
    public var body: some View {
        GeometryReader { geometry in
            // This is the key fix for adaptive layout.
            // On wide screens, use a side-by-side layout.
            if geometry.size.width > 600 {
                HStack(spacing: 0) {
                    imageView()
                        .frame(width: geometry.size.width * 0.55)
                        .clipped()
                    
                    LoginForm(viewModel: viewModel)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                }
            } else {
                // On narrow screens (like iPhone), use a vertical layout.
                ScrollView {
                    // We use a ZStack to allow the form to potentially overlap the image if needed
                    ZStack(alignment: .top) {
                        // The image is placed at the top
                        imageView()
                            .frame(height: geometry.size.height * 0.35)
                            .clipped()
                        
                        // The form is placed in a VStack below the image area
                        LoginForm(viewModel: viewModel)
                            .padding(.top, geometry.size.height * 0.3)
                            .background(Color.white)
                    }
                }
                .background(Color.white)
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.light)
    }
}

// MARK: - Login Form
private struct LoginForm: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            
            Text("PRAANYA")
                .font(.system(size: 32, weight: .light, design: .default))
                .kerning(10)
                .foregroundColor(.black)
                .padding(.bottom, 35)
            
            Text("Log in below or sign up to create an account")
                .foregroundColor(Color(.systemGray))
                .font(.system(size: 14))
                .padding(.bottom, 25)
            
            HStack(spacing: 15) {
                SocialLoginButton(iconName: "g.circle.fill", text: "Google")
                SocialLoginButton(iconName: "f.circle.fill", text: "Facebook")
            }
            .padding(.bottom, 25)
            
            HStack(spacing: 15) {
                dividerLine()
                Text("or").foregroundColor(Color(.systemGray))
                dividerLine()
            }
            .padding(.bottom, 25)
            
            VStack(spacing: 15) {
                StyledTextField(placeholder: "Username or email", text: $viewModel.email)
                StyledSecureField(placeholder: "Password", text: $viewModel.password)
            }
            .padding(.bottom, 25)
            
            if viewModel.isLoading {
                ProgressView().frame(height: 50)
            } else {
                Button(action: viewModel.signIn) {
                    Text("Log in")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
            }
            
            // The NavigationLink will push to the ForgotPasswordView
            NavigationLink("Forgot password?") {
                ForgotPasswordView(viewModel: viewModel)
            }
            .buttonStyle(.plain)
            .font(.system(size: 14))
            .foregroundColor(Color(.systemGray))
            .padding(.top, 15)
            
            Spacer()

            // This is the restored Sign Up button
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.black)
                
                // The NavigationLink will push to the SignUpView
                NavigationLink("Sign up") {
                    SignUpView(viewModel: viewModel)
                }
                .buttonStyle(.plain)
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 50)
        .frame(maxWidth: 420)
    }
    
    // Helper view for the divider line
    private func dividerLine() -> some View {
        #if os(iOS)
        return Rectangle().frame(height: 1).foregroundColor(Color(.systemGray5))
        #else
        return Rectangle().frame(height: 1).foregroundColor(Color(NSColor.gridColor))
        #endif
    }
}


// MARK: - Reusable UI Components (Cross-Platform)

private struct SocialLoginButton: View {
    let iconName: String
    let text: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: iconName)
                    .font(.system(size: 20))
                Text(text)
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    #if os(iOS)
                    .stroke(Color(.systemGray4))
                    #else
                    .stroke(Color(NSColor.separatorColor))
                    #endif
            )
        }
        .buttonStyle(.plain)
    }
}

private struct StyledTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        let field = TextField(placeholder, text: $text)
            .font(.system(size: 14))
            .padding(.horizontal, 15)
            .frame(height: 50)
            .cornerRadius(10)
            .textFieldStyle(.plain)
            .disableAutocorrection(true)

        #if os(iOS)
        field
            .background(Color(.systemGray6))
            .autocapitalization(.none)
        #else
        field
            .background(Color(NSColor.controlBackgroundColor))
        #endif
    }
}

private struct StyledSecureField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        let field = SecureField(placeholder, text: $text)
            .font(.system(size: 14))
            .padding(.horizontal, 15)
            .frame(height: 50)
            .cornerRadius(10)
            .textFieldStyle(.plain)
        
        #if os(iOS)
        field
            .background(Color(.systemGray6))
        #else
        field
            .background(Color(NSColor.controlBackgroundColor))
        #endif
    }
}
