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
    
    /// A custom initializer to create a new User object after sign-up.
    init(uid: String, email: String?, name: String) {
        self.uid = uid
        self.email = email
        self.name = name
        
        // Default values for a new user
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
