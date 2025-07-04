import Foundation

/// Manages the state and logic for the user's profile screen.
@MainActor
final class ProfileViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// The user's profile data, passed in during initialization.
    @Published private(set) var user: User?
    @Published private(set) var accomplishments: [Accomplishment] = []
    
    // MARK: - Init
    
    init(user: User?) {
        self.user = user
        loadAccomplishments()
    }
    
    // MARK: - Public Methods
    
    func signOut(sessionManager: SessionManager) {
        sessionManager.signOut()
    }
    
    // MARK: - Private Methods
    
    private func loadAccomplishments() {
        // TODO: Fetch user's accomplishments from Firestore.
        self.accomplishments = Accomplishment.mockData
    }
}
