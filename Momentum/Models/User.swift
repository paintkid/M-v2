// Models/User.swift

import Foundation
import FirebaseFirestore
import FirebaseAuth

/// Represents a user profile stored in Firestore.
struct User: Identifiable, Codable {
    
    // MARK: - Properties
    
    @DocumentID var id: String?
    let uid: String
    let email: String?
    var name: String
    var avatarURL: String?
    
    // MARK: - Init
    
    /// A custom initializer to create a User from a Firebase Auth user object.
    /// This is used by the SessionManager when the auth state changes.
    init(from authUser: FirebaseAuth.User) {
        self.uid = authUser.uid
        self.email = authUser.email
        self.name = authUser.displayName ?? ""
        self.avatarURL = authUser.photoURL?.absoluteString
    }
    
    /// A custom initializer to create a new User object after sign-up.
    /// This is used by the AuthenticationViewModel.
    init(uid: String, email: String?, name: String) {
        self.uid = uid
        self.email = email
        self.name = name
        self.avatarURL = nil // A new user won't have an avatar URL yet.
    }
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case email
        case name
        case avatarURL = "avatar_url"
    }
}
