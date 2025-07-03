import Foundation

/// Manages the state and logic for user authentication screens (Login, Sign Up).
@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var error: String?
    @Published var isLoading = false
    
    // MARK: - Public Methods
    
    func signIn() async -> Bool {
        // TODO: Implement form validation before attempting sign-in.
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await AuthenticationService.shared.signIn(withEmail: email, password: password)
            return true
        } catch {
            self.error = error.localizedDescription
            print("Error signing in: \(error.localizedDescription)")
            return false
        }
    }
    
    func signUp() async -> Bool {
        // TODO: Implement form validation, including password matching.
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await AuthenticationService.shared.signUp(withEmail: email, password: password)
            // TODO: After sign-up, create a corresponding user document in Firestore.
            return true
        } catch {
            self.error = error.localizedDescription
            print("Error signing up: \(error.localizedDescription)")
            return false
        }
    }
    
    func sendPasswordReset() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await AuthenticationService.shared.sendPasswordReset(to: email)
            // TODO: Show a confirmation message to the user.
        } catch {
            self.error = error.localizedDescription
            print("Error sending password reset: \(error.localizedDescription)")
        }
    }
}
