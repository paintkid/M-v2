import Foundation
import FirebaseAuth
import Combine

/// Manages the user's authentication state (UID) and session across the app.
final class SessionManager: ObservableObject {
    
    // MARK: - Published Properties
    
    /// The unique identifier of the currently authenticated user.
    @Published private(set) var userUID: String?
    
    // MARK: - Properties
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    // MARK: - Init
    
    init() {
        // When the app starts, immediately set the UID if a user is already logged in.
        self.userUID = Auth.auth().currentUser?.uid
        addAuthStateListener()
    }
    
    // MARK: - Public Methods
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            // TODO: Handle sign-out errors, perhaps with a user-facing alert.
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Private Methods
    
    private func addAuthStateListener() {
        authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] _, firebaseUser in
            DispatchQueue.main.async {
                // This is the core architectural change. We only store the UID.
                // The full user profile will be fetched from Firestore by the ProfileView.
                self?.userUID = firebaseUser?.uid
                
                if let uid = firebaseUser?.uid {
                    print("SessionManager: User is signed in with UID: \(uid)")
                } else {
                    print("SessionManager: User is signed out.")
                }
            }
        }
    }
}
