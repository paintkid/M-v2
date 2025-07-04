import SwiftUI

struct ProfileView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var sessionManager: SessionManager
    @StateObject private var viewModel: ProfileViewModel
    
    // MARK: - Init
    
    init(user: User?) {
        // Initializes the StateObject with the user passed from the parent view.
        _viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                
                if let user = viewModel.user {
                    profileContent(for: user)
                } else {
                    // This case handles when the view appears before the user data is available.
                    ProgressView()
                        .frame(maxHeight: .infinity)
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Profile")
                .font(.largeTitle).bold()
                .foregroundColor(.appTextPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.appBackground)
    }
    
    private func profileContent(for user: User) -> some View {
        VStack(spacing: 24) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.appTextTertiary)
            
            VStack(spacing: 4) {
                Text(user.name)
                    .font(.title2).bold()
                    .foregroundColor(.appTextPrimary)
                
                Text(user.email ?? "No email provided")
                    .font(.subheadline)
                    .foregroundColor(.appTextSecondary)
            }
            
            Spacer()
            
            Button(role: .destructive, action: {
                viewModel.signOut(sessionManager: sessionManager)
            }) {
                Text("Sign Out")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding()
    }
}

// MARK: - Previews
#Preview {
    // We create a mock user for the preview to work.
    let mockUser = User(uid: "123", email: "preview@example.com", name: "Preview User")
    return ProfileView(user: mockUser)
}
