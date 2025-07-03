// Services/SessionManager.swift

import Foundation
import FirebaseAuth
import Combine

/// Manages the user's authentication state and session across the app.
final class SessionManager: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published private(set) var currentUser: User?
    
    // MARK: - Properties
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    // MARK: - Init
    
    init() {
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
            if let firebaseUser = firebaseUser {
                // This uses the new, explicit initializer from the User model.
                self?.currentUser = User(from: firebaseUser)
                print("SessionManager: User is signed in with UID: \(firebaseUser.uid)")
            } else {
                self?.currentUser = nil
                print("SessionManager: User is signed out.")
            }
        }
    }
}
