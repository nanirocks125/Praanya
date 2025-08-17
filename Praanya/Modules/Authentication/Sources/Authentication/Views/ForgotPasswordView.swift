import SwiftUI

// MARK: - Forgot Password View (Container)
public struct ForgotPasswordView<ImageView: View>: View {
    @ObservedObject var viewModel: AuthViewModel
    let imageView: () -> ImageView

    public var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > 600 {
                HStack(spacing: 0) {
                    imageView()
                        .frame(width: geometry.size.width * 0.55)
                        .clipped()
                    
                    ForgotPasswordForm(viewModel: viewModel)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                }
            } else {
                ScrollView {
                    ZStack(alignment: .top) {
                        imageView()
                            .frame(height: geometry.size.height * 0.35)
                            .clipped()
                        
                        ForgotPasswordForm(viewModel: viewModel)
                            .padding(.top, geometry.size.height * 0.3)
                            .background(Color.white)
                    }
                }
                .background(Color.white)
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Forgot Password Form
private struct ForgotPasswordForm: View {
    @ObservedObject var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            
            Text("RESET PASSWORD")
                .font(.system(size: 32, weight: .light, design: .default))
                .kerning(4)
                .foregroundColor(.black)
                .padding(.bottom, 35)
            
            Text("Enter your email to receive a password reset link")
                .foregroundColor(Color(.systemGray))
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .padding(.bottom, 25)
            
            VStack(spacing: 15) {
                StyledTextField(placeholder: "Email", text: $viewModel.email)
            }
            .padding(.bottom, 25)
            
            if viewModel.isLoading {
                ProgressView().frame(height: 50)
            } else {
                Button(action: viewModel.forgotPassword) {
                    Text("Send Reset Link")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
            }
            
            Spacer()

            HStack {
                Text("Remember your password?")
                    .foregroundColor(.black)
                
                Button("Log in") {
                    dismiss()
                }
                .buttonStyle(.plain)
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 50)
        .frame(maxWidth: 420)
        .background(Color.white)
    }
}
