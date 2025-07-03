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
        self.name = authUser.displayName ?? "" // Default to empty string if no display name
        self.avatarURL = authUser.photoURL?.absoluteString
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
