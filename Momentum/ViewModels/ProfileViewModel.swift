import Foundation

/// Manages the state and logic for the user's profile screen by fetching data from Firestore.
@MainActor
final class ProfileViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published private(set) var user: User?
    @Published private(set) var accomplishments: [Accomplishment] = []
    
    // MARK: - Properties
    
    private let userUID: String
    
    // MARK: - Init
    
    init(userUID: String) {
        self.userUID = userUID
    }
    
    // MARK: - Public Methods
    
    func fetchUserProfile() async {
        guard !userUID.isEmpty else { return }
        do {
            self.user = try await FirestoreService.shared.fetchUser(withID: userUID)
            print("Successfully fetched user profile for UID: \(userUID)")
        } catch {
            // TODO: Handle fetch errors with a user-facing alert.
            print("Error fetching user profile: \(error.localizedDescription)")
        }
    }
    
    func loadAccomplishments() {
        // TODO: Fetch user's accomplishments from Firestore.
        self.accomplishments = Accomplishment.mockData
    }
    
    func signOut(sessionManager: SessionManager) {
        sessionManager.signOut()
    }
}
