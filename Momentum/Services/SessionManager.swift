import Foundation
import FirebaseAuth
import Combine

/// Manages the user's authentication state and session across the app.
final class SessionManager: ObservableObject {
    
    // MARK: - Published Properties
    
    /// The currently authenticated user. The UI will react to changes to this property.
    @Published private(set) var currentUser: User?
    
    // MARK: - Properties
    
    /// A handle to the Firebase Auth state listener.
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    // MARK: - Init
    
    init() {
        // Start listening for authentication changes as soon as the app starts.
        addAuthStateListener()
    }
    
    // MARK: - Public Methods
    
    /// Signs the current user out.
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            // TODO: Handle sign-out errors, perhaps with a user-facing alert.
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Private Methods
    
    /// Attaches a listener to Firebase Auth that updates `currentUser` on any change.
    private func addAuthStateListener() {
        authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] _, firebaseUser in
            // This closure is called whenever a user signs in or out.
            if let firebaseUser = firebaseUser {
                // User is signed in.
                self?.currentUser = User(from: firebaseUser)
                print("SessionManager: User is signed in with UID: \(firebaseUser.uid)")
            } else {
                // User is signed out.
                self?.currentUser = nil
                print("SessionManager: User is signed out.")
            }
        }
    }
}
