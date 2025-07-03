// ViewModels/NotificationsViewModel.swift

import Foundation

/// Manages the state and logic for the Notifications screen.
/// Conforming to `ObservableObject` allows SwiftUI views to subscribe to its changes.
@MainActor
class NotificationsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var notifications: [Notification] = []
    
    // MARK: - Init
    
    init() {
        loadNotifications()
    }
    
    // MARK: - Public Methods (User Actions)
    
    func acceptInvite(for notificationId: String) {
        print("Accepted invite for notification: \(notificationId)")
        // TODO: Implement network request to accept the invite on the server.
        removeNotification(withId: notificationId)
    }
    
    func declineInvite(for notificationId: String) {
        print("Declined invite for notification: \(notificationId)")
        // TODO: Implement network request to decline the invite on the server.
        removeNotification(withId: notificationId)
    }
    
    func markAsRead(notificationId: String) {
        guard let index = notifications.firstIndex(where: { $0.id == notificationId }) else { return }
        
        // Avoids unnecessary UI updates if already read.
        if !notifications[index].isRead {
            notifications[index].isRead = true
            print("Marked notification \(notificationId) as read.")
            // TODO: Implement network request to mark notification as read on the server.
        }
    }
    
    // MARK: - Private Methods
    
    private func loadNotifications() {
        // TODO: Replace mock data with a network call to fetch real notifications.
        self.notifications = Notification.mockData
    }
    
    private func removeNotification(withId id: String) {
        notifications.removeAll { $0.id == id }
    }
}
