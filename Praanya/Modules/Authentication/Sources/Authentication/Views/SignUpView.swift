import SwiftUI

// MARK: - New Sign Up View (Container)
public struct SignUpView<ImageView: View>: View {
    @ObservedObject var viewModel: AuthViewModel
    let imageView: () -> ImageView

    public var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > 600 {
                HStack(spacing: 0) {
                    imageView()
                        .frame(width: geometry.size.width * 0.55)
                        .clipped()
                    
                    SignUpForm(viewModel: viewModel)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                }
            } else {
                ScrollView {
                    ZStack(alignment: .top) {
                        imageView()
                            .frame(height: geometry.size.height * 0.35)
                            .clipped()
                        
                        SignUpForm(viewModel: viewModel)
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

// MARK: - Sign Up Form
private struct SignUpForm: View {
    @ObservedObject var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            
            Text("CREATE ACCOUNT")
                .font(.system(size: 32, weight: .light, design: .default))
                .kerning(4)
                .foregroundColor(.black)
                .padding(.bottom, 35)
            
            Text("Enter your details below to create an account")
                .foregroundColor(Color(.systemGray))
                .font(.system(size: 14))
                .padding(.bottom, 25)
            
            VStack(spacing: 15) {
                StyledTextField(placeholder: "Email", text: $viewModel.email)
                StyledSecureField(placeholder: "Password", text: $viewModel.password)
                StyledSecureField(placeholder: "Confirm Password", text: $viewModel.confirmPassword)
            }
            .padding(.bottom, 25)
            
            if viewModel.isLoading {
                ProgressView().frame(height: 50)
            } else {
                Button(action: viewModel.signUp) {
                    Text("Sign Up")
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
                Text("Already have an account?")
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
