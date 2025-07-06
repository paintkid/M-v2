import SwiftUI

struct CreateUsernameView: View {
    
    // MARK: - Properties
    
    // Changed to @ObservedObject to allow injection for previews
    @ObservedObject var viewModel: CreateUsernameViewModel
    @EnvironmentObject private var sessionManager: SessionManager
    let user: User
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                header
                
                IconTextField(
                    iconName: "at",
                    placeholder: "Username",
                    text: $viewModel.username
                )
                .textContentType(.username)
                
                validationMessage
                
                Button(action: handleCompleteProfile) {
                    Text("Complete Sign Up")
                }
                .buttonStyle(PrimaryButtonStyle(isDisabled: viewModel.validationState != .available))
                .disabled(viewModel.validationState != .available)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .overlay(loadingOverlay)
    }
    
    // MARK: - Private Views
    
    private var header: some View {
        VStack(spacing: 8) {
            Text("Choose a Username")
                .font(.largeTitle).bold()
                .foregroundColor(.appTextPrimary)
            
            Text("Choose a unique username for your profile.")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    private var validationMessage: some View {
        HStack {
            Group {
                switch viewModel.validationState {
                case .empty:
                    Text("Your unique username will be public.")
                case .checking:
                    ProgressView()
                    Text("Checking availability...")
                case .available:
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Username is available!")
                case .unavailable(let message):
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                    Text(message)
                case .invalid(let message):
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                    Text(message)
                }
            }
            .font(.caption)
            .foregroundColor(.appTextSecondary)
            
            Spacer()
        }
        .frame(height: 20)
    }
    
    @ViewBuilder
    private var loadingOverlay: some View {
        if viewModel.isLoading {
            ZStack {
                Color(white: 0, opacity: 0.75)
                ProgressView().tint(.white)
            }
            .ignoresSafeArea()
        }
    }
    
    // MARK: - Private Methods
    
    private func handleCompleteProfile() {
        Task {
            let success = await viewModel.completeProfileCreation(forUID: user.uid)
            if success {
                print("Username set successfully. Onboarding complete.")
            }
        }
    }
}

// MARK: - Previews
#Preview("Available") {
    // Corrected: We now create a mock ViewModel and inject it into the view.
    let vm = CreateUsernameViewModel()
    vm.validationState = .available
    return CreateUsernameView(viewModel: vm, user: User.mock)
        .environmentObject(SessionManager())
}

#Preview("Unavailable") {
    let vm = CreateUsernameViewModel()
    vm.validationState = .unavailable("Username is already taken.")
    return CreateUsernameView(viewModel: vm, user: User.mock)
        .environmentObject(SessionManager())
}
