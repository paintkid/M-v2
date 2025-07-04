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
    var username: String? // Corrected: Username is now optional.
    var bio: String
    var avatarURL: String?
    var stats: Stats?
    
    // MARK: - Nested Types
    
    struct Stats: Codable {
        var roomsCompleted: Int
        var totalDays: Int
        var currentStreak: Int
    }
    
    // MARK: - Initializers
    
    /// Creates a User object from a Firebase Auth user. Used by the SessionManager.
    init(authUser: FirebaseAuth.User) {
        self.uid = authUser.uid
        self.email = authUser.email
        self.name = authUser.displayName ?? ""
        self.username = nil // The full profile must be fetched from Firestore.
        self.bio = ""
        self.avatarURL = authUser.photoURL?.absoluteString
        self.stats = nil
    }
    
    /// Creates a new, partial User object after initial sign-up.
    init(uid: String, email: String?, name: String) {
        self.uid = uid
        self.email = email
        self.name = name
        self.username = nil // Username is set in the next step.
        self.bio = ""
        self.avatarURL = nil
        self.stats = Stats(roomsCompleted: 0, totalDays: 0, currentStreak: 0)
    }
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id, uid, email, name, username, bio, stats
        case avatarURL = "avatar_url"
    }
}

// MARK: - Mock Data
extension User {
    /// A mock user for previews and testing.
    static let mock: User = {
        var user = User(uid: "mock_user_123", email: "alexj@example.com", name: "Alex Johnson")
        user.username = "@alexj"
        user.bio = "Building better habits one day at a time 💪"
        user.stats = Stats(roomsCompleted: 12, totalDays: 847, currentStreak: 23)
        return user
    }()
}
