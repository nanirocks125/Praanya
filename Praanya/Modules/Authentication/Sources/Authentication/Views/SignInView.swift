import SwiftUI

#if os(macOS)
import AppKit
#endif

// MARK: - Main Public Login View
/// A redesigned, configurable login screen that adapts for iOS and macOS.
public struct SignInView<ImageView: View>: View {
    @ObservedObject var viewModel: AuthViewModel
    let imageView: () -> ImageView
    
    // The initializer requires a ViewBuilder closure for the image,
    // making it completely configurable from the outside.
    public init(viewModel: AuthViewModel, @ViewBuilder imageView: @escaping () -> ImageView) {
        self.viewModel = viewModel
        self.imageView = imageView
    }
    
    public var body: some View {
        GeometryReader { geometry in
            // Use HStack for wider screens (macOS, iPad landscape)
            if geometry.size.width > 600 {
                HStack(spacing: 0) {
                    imageView()
                        .frame(width: geometry.size.width * 0.55)
                        .clipped()
                    
                    LoginForm(viewModel: viewModel)
                        .frame(maxWidth: .infinity)
                }
                .ignoresSafeArea()
            } else {
                // Use VStack for narrower screens (iPhone)
                ZStack {
                    // On mobile, the image can act as a background
                    imageView()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: geometry.size.height * 0.4)
                        .ignoresSafeArea()
                        .offset(y: -geometry.size.height * 0.2)
                    
                    ScrollView {
                        LoginForm(viewModel: viewModel)
                            .padding(.top, geometry.size.height * 0.25)
                    }
                }
            }
        }
        .background(Color.white)
    }
}

// MARK: - Login Form
/// The right-hand side of the login screen.
private struct LoginForm: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            // 1. Logo
            Text("PRAANYA")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .kerning(8) // Adds spacing between letters
                .padding(.vertical, 40)
            
            // 2. Sub-headline
            Text("Log in below or sign up to create an account")
                .foregroundColor(.gray)
                .font(.subheadline)
            
            // 3. Social Login Buttons
            HStack {
                SocialLoginButton(iconName: "g.circle.fill", text: "Google")
                SocialLoginButton(iconName: "f.circle.fill", text: "Facebook")
            }
            
            // 4. Divider
            HStack {
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.2))
                Text("or").foregroundColor(.gray)
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.2))
            }
            .padding(.vertical)
            
            // 5. Text Fields
            VStack {
                AuthTextField(placeholder: "Username or email", text: $viewModel.email)
                AuthSecureField(placeholder: "Password", text: $viewModel.password)
            }
            
            // 6. Login Button
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button(action: viewModel.signIn) {
                    Text("Log in")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                }
            }
            
            // 7. Forgot Password
            Button(action: viewModel.forgotPassword) {
                Text("Forgot password?")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // 8. Sign Up Link
            HStack {
                Text("Don't have an account?")
                NavigationLink(value: "SignUp") {
                    // TODO: Add navigation to your sign up screen
                    Text("Sign up")
                }
            }
            .padding(.bottom)
            
        }
        .padding(.horizontal, 40)
        .frame(maxWidth: 400) // Constrain form width on large screens
    }
}


// MARK: - Reusable UI Components

private struct SocialLoginButton: View {
    let iconName: String
    let text: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: iconName)
                    .font(.title2)
                Text(text)
            }
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
        }
    }
}
