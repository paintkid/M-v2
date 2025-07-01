//
//  Room.swift
//  Momentum
//
//  Created by joel on 7/1/25.
//

import Foundation

struct Room: Identifiable {
    let id: String
    let name: String
    let progress: Progress
    let memberAvatarUrls: [String]
    let hasNewActivity: Bool
    let lastActivity: String
    let streak: Int

    struct Progress {
        let current: Int
        let total: Int
    }

    var progressPercentage: Double {
        return Double(progress.current) / Double(progress.total)
    }
}

extension Room {
    static let mockData: [Room] = [
        Room(
            id: "1",
            name: "Morning Workout Squad",
            progress: .init(current: 15, total: 30),
            memberAvatarUrls: ["avatar1", "avatar2", "avatar3", "avatar4"],
            hasNewActivity: true,
            lastActivity: "2 hours ago",
            streak: 15
        ),
        Room(
            id: "2",
            name: "Daily Meditation",
            progress: .init(current: 8, total: 21),
            memberAvatarUrls: ["avatar5", "avatar6"],
            hasNewActivity: false,
            lastActivity: "1 day ago",
            streak: 8
        ),
        Room(
            id: "3",
            name: "Learn Spanish Together",
            progress: .init(current: 42, total: 60),
            memberAvatarUrls: ["avatar1", "avatar3", "avatar6"],
            hasNewActivity: true,
            lastActivity: "30 minutes ago",
            streak: 12
        )
    ]
}
