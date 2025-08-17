import SwiftUI

#if os(macOS)
import AppKit
#endif

// MARK: - 1. Page State Enum
/// An enum to manage which authentication form is currently visible.
public enum AuthPage {
    case login, signUp, forgotPassword
}

// MARK: - 2. Main Public Authentication View (The Container)
/// The single, public entry point for the entire authentication flow.
public struct AuthenticationFlowView<ImageView: View>: View {
    @StateObject private var viewModel: AuthViewModel
    private let imageView: () -> ImageView
    
    // The state that controls which form is shown on the right side.
    @State private var currentPage: AuthPage = .login

    public init(viewModel: AuthViewModel, @ViewBuilder imageView: @escaping () -> ImageView) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.imageView = imageView
    }

    public var body: some View {
        GeometryReader { geometry in
            // The adaptive layout is now in one single place.
            if geometry.size.width > 600 {
                HStack(spacing: 0) {
                    imageView()
                        .frame(width: geometry.size.width * 0.55)
                        .clipped()
                    
                    formSwitch()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                }
            } else {
                ScrollView {
                    ZStack(alignment: .top) {
                        imageView()
                            .frame(height: geometry.size.height * 0.35)
                            .clipped()
                        
                        formSwitch()
                            .padding(.top, geometry.size.height * 0.3)
                            .background(Color.white)
                    }
                }
                .background(Color.white)
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.light)
        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(title: Text("Authentication"), message: Text(viewModel.alertMessage ?? "An error occurred."), dismissButton: .default(Text("OK")))
        }
    }
    
    /// A helper view that switches between the different authentication forms.
    @ViewBuilder
    private func formSwitch() -> some View {
        // The switch determines which form to display based on the currentPage state.
        switch currentPage {
        case .login:
            LoginForm(viewModel: viewModel, currentPage: $currentPage)
        case .signUp:
            SignUpForm(viewModel: viewModel, currentPage: $currentPage)
        case .forgotPassword:
            ForgotPasswordForm(viewModel: viewModel, currentPage: $currentPage)
        }
    }
}

// MARK: - 3. Individual Forms (Updated)



