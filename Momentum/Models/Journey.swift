import Foundation

struct Journey: Identifiable {
    let id: String
    let user: User
    let title: String
    let beforePhotoURL: String
    let afterPhotoURL: String
    let summary: String
    var encouragement: Encouragement // Changed to var
    let daysAgo: Int
    
    struct User {
        let name: String
        let avatarURL: String
    }
    
    struct Encouragement {
        let users: [String]
        var totalCount: Int // Changed to var
    }
}

// MARK: - Mock Data
extension Journey {
    static var mockData: [Journey] = [ // Changed to var to allow modification in previews/tests
        .init(
            id: "1",
            user: .init(name: "Sarah Chen", avatarURL: "placeholder_avatar"),
            title: "30-Day Morning Workout",
            beforePhotoURL: "placeholder_before_1",
            afterPhotoURL: "placeholder_after_1",
            summary: "Started with just 10 push-ups and now I can do 50! The consistency really paid off. My energy levels are through the roof and I feel stronger than ever.",
            encouragement: .init(users: ["Mike Rodriguez", "Emma Thompson", "Alex Kim"], totalCount: 47),
            daysAgo: 2
        ),
        .init(
            id: "2",
            user: .init(name: "Mike Rodriguez", avatarURL: "placeholder_avatar"),
            title: "60-Day Meditation Journey",
            beforePhotoURL: "placeholder_before_2",
            afterPhotoURL: "placeholder_after_2",
            summary: "From 5 minutes of fidgeting to 30 minutes of pure calm. This journey taught me patience with myself and the power of small daily actions.",
            encouragement: .init(users: ["Sarah Chen", "Jordan Lee"], totalCount: 32),
            daysAgo: 5
        ),
        .init(
            id: "3",
            user: .init(name: "Emma Thompson", avatarURL: "placeholder_avatar"),
            title: "90-Day Coding Challenge",
            beforePhotoURL: "placeholder_before_3",
            afterPhotoURL: "placeholder_after_3",
            summary: "From \"Hello World\" to building my first app! Every day of coding, even just 30 minutes, added up to something amazing.",
            encouragement: .init(users: ["David Park", "Lisa Wang", "Tom Wilson"], totalCount: 63),
            daysAgo: 1
        )
    ]
}
