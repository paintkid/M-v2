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
    var username: String
    var bio: String
    var avatarURL: String?
    var stats: Stats
    
    // MARK: - Nested Types
    
    struct Stats: Codable {
        var roomsCompleted: Int
        var totalDays: Int
        var currentStreak: Int
    }
    
    // MARK: - Init
    
    /// A custom initializer to create a User from a Firebase Auth user object.
    /// This is used by the SessionManager when the auth state changes.
    init(from authUser: FirebaseAuth.User) {
        self.uid = authUser.uid
        self.email = authUser.email
        self.name = authUser.displayName ?? ""
        self.username = "@\(authUser.displayName?.lowercased().filter { !$0.isWhitespace } ?? "newuser")"
        self.bio = ""
        self.avatarURL = authUser.photoURL?.absoluteString
        self.stats = Stats(roomsCompleted: 0, totalDays: 0, currentStreak: 0)
    }
    
    /// A custom initializer to create a new User object after sign-up.
    /// This is used by the AuthenticationViewModel.
    init(uid: String, email: String?, name: String) {
        self.uid = uid
        self.email = email
        self.name = name
        self.username = "@\(name.lowercased().filter { !$0.isWhitespace })"
        self.bio = ""
        self.avatarURL = nil
        self.stats = Stats(roomsCompleted: 0, totalDays: 0, currentStreak: 0)
    }
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case email
        case name
        case username
        case bio
        case avatarURL = "avatar_url"
        case stats
    }
}

// MARK: - Mock Data
extension User {
    static let mock = User(
        uid: "mock_user_123",
        email: "alexj@example.com",
        name: "Alex Johnson"
    )
}
