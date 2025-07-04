import Foundation

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
    
    var isSignUpFormValid: Bool {
        !name.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        acceptsTerms
    }
    
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
            
            let newUser = User(
                uid: authResult.user.uid,
                email: authResult.user.email,
                name: self.name
            )
            
            // Corrected: Removed the unnecessary `await` keyword.
            try FirestoreService.shared.createUserDocument(user: newUser)
            
            print("Sign up and user document creation successful.")
            return true
        } catch {
            self.error = error.localizedDescription
            print("Error during sign up process: \(error.localizedDescription)")
            // TODO: Implement logic to delete the created auth user if the firestore write fails.
            return false
        }
    }
    
    func sendPasswordReset() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await AuthenticationService.shared.sendPasswordReset(to: email)
        } catch {
            self.error = error.localizedDescription
            print("Error sending password reset: \(error.localizedDescription)")
        }
    }
}
