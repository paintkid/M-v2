import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State private var didSignUpSuccessfully = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    header.padding(.bottom, 12)
                    emailForm
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Create Account")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { navigationToolbar }
        .overlay(loadingOverlay)
        .navigationDestination(isPresented: $didSignUpSuccessfully) {
            let user = User(
                uid: Auth.auth().currentUser?.uid ?? "",
                email: viewModel.email,
                name: viewModel.name
            )
            // Corrected: We now correctly inject a new ViewModel instance
            // into the CreateUsernameView, matching its new initializer.
            CreateUsernameView(viewModel: CreateUsernameViewModel(), user: user)
        }
    }
    
    // MARK: - Private Views
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Create Account").font(.largeTitle).bold().foregroundColor(.appTextPrimary)
            Text("Start building better habits with friends.").font(.subheadline).foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var emailForm: some View {
        VStack(spacing: 16) {
            IconTextField(iconName: "person.fill", placeholder: "Full Name", text: $viewModel.name)
            IconTextField(iconName: "envelope.fill", placeholder: "Email", text: $viewModel.email)
            SecureIconTextField(iconName: "lock.fill", placeholder: "Password", text: $viewModel.password)
            SecureIconTextField(iconName: "lock.fill", placeholder: "Confirm Password", text: $viewModel.confirmPassword)
            
            if let error = viewModel.error {
                Text(error).font(.caption).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading)
            }
            
            termsToggle.padding(.top)
            
            Button(action: handleSignUp) {
                Text("Continue")
            }
            .buttonStyle(PrimaryButtonStyle(isDisabled: !viewModel.isSignUpFormValid))
            .disabled(!viewModel.isSignUpFormValid)
            .padding(.top)
        }
    }
    
    private var termsToggle: some View {
        HStack(spacing: 12) {
            Button(action: { viewModel.acceptsTerms.toggle() }) {
                Image(systemName: viewModel.acceptsTerms ? "checkmark.square.fill" : "square")
                    .font(.title2)
                    .foregroundColor(viewModel.acceptsTerms ? .appPurple : .appTextTertiary)
            }
            (Text("I agree to the ") + Text("Terms of Service").foregroundColor(.appPurple) + Text(" and ") + Text("Privacy Policy").foregroundColor(.appPurple))
                .font(.footnote).foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var loadingOverlay: some View {
        if viewModel.isLoading {
            ZStack {
                Color(white: 0, opacity: 0.75)
                ProgressView().tint(.white)
            }.ignoresSafeArea()
        }
    }
    
    @ToolbarContentBuilder
    private var navigationToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { dismiss() }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.appPurple)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func handleSignUp() {
        Task {
            let success = await viewModel.signUp()
            if success {
                self.didSignUpSuccessfully = true
            }
        }
    }
}

// MARK: - Previews
#Preview {
    NavigationStack {
        SignUpView()
    }
}
