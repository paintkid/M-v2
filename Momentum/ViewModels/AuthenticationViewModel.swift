import Foundation

/// Manages the state and logic for user authentication screens (Login, Sign Up).
@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var acceptsTerms = false
    
    @Published var error: String?
    @Published var isLoading = false
    
    // MARK: - Computed Properties
    
    /// A computed property to determine if the sign-up form is valid.
    var isSignUpFormValid: Bool {
        !name.isEmpty &&
        !email.isEmpty && // TODO: Add proper email validation.
        !password.isEmpty &&
        password == confirmPassword &&
        acceptsTerms
    }
    
    /// A computed property to determine if the login form is valid.
    var isLoginFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    // MARK: - Public Methods
    
    func signIn() async -> Bool {
        guard isLoginFormValid else { return false }
        
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
        guard isSignUpFormValid else { return false }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let authResult = try await AuthenticationService.shared.signUp(withEmail: email, password: password)
            print("Sign up successful for user: \(authResult.user.uid)")
            // TODO: After sign-up, create a corresponding user document in Firestore with the `name` property.
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
