// Services/AuthenticationService.swift

import Foundation
import FirebaseAuth

/// A service class responsible for all Firebase Authentication operations.
final class AuthenticationService {
    
    // MARK: - Properties
    
    static let shared = AuthenticationService()
    
    // MARK: - Private Init
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Creates a new user account with the specified email and password.
    /// - Parameter email: The user's email address.
    /// - Parameter password: The user's chosen password.
    /// - Throws: An error if the account creation fails.
    /// - Returns: The newly created user object from Firebase.
    @discardableResult
    func signUp(withEmail email: String, password: String) async throws -> AuthDataResult {
        // TODO: Add validation for email format and password strength.
        return try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    /// Signs in an existing user with the specified email and password.
    /// - Parameter email: The user's email address.
    /// - Parameter password: The user's password.
    /// - Throws: An error if the sign-in process fails.
    /// - Returns: The signed-in user object from Firebase.
    @discardableResult
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    /// Signs the current user out.
    /// - Throws: An error if the sign-out process fails.
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    /// Sends a password reset email to the specified address.
    /// - Parameter email: The email address to send the reset link to.
    /// - Throws: An error if the email fails to send.
    func sendPasswordReset(to email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
