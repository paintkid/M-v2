import Foundation

/// Represents a single notification item in the user's feed.
struct Notification: Identifiable {
    let id: String
    var type: NotificationType
    let user: User
    let message: String
    let time: String
    var isRead: Bool
    
    /// Defines the different kinds of notifications the app can have.
    enum NotificationType: String {
        case like
        case comment
        case invite
        case post
    }
    
    /// A nested struct representing the user associated with the notification.
    struct User {
        let name: String
        let avatarURL: String
    }
}

// MARK: - Mock Data
extension Notification {
    /// Provides static mock data for previews and initial development.
    static let mockData: [Notification] = [
        .init(id: "1", type: .like, user: .init(name: "Sarah Chen", avatarURL: "placeholder"), message: "liked your post in Morning Workout Squad", time: "2 hours ago", isRead: false),
        .init(id: "2", type: .comment, user: .init(name: "Mike Rodriguez", avatarURL: "placeholder"), message: "commented on your post: \"Great form! Keep it up! 💪\"", time: "4 hours ago", isRead: false),
        .init(id: "3", type: .invite, user: .init(name: "Emma Thompson", avatarURL: "placeholder"), message: "invited you to join \"Daily Meditation\"", time: "1 day ago", isRead: false),
        .init(id: "4", type: .post, user: .init(name: "Alex Kim", avatarURL: "placeholder"), message: "posted in Learn Spanish Together", time: "1 day ago", isRead: true),
        .init(id: "5", type: .like, user: .init(name: "Jordan Lee", avatarURL: "placeholder"), message: "liked your post in Daily Meditation", time: "2 days ago", isRead: true),
    ]
}
