// Views/Components/NotificationRowView.swift

import SwiftUI

/// A view that displays a single notification row with a modern, seamless style.
struct NotificationRowView: View {
    
    // MARK: - Properties
    
    let notification: Notification
    var onAction: ((Action) -> Void)?
    
    enum Action {
        case accept, decline
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 12) {
                userAvatar
                messageText
                Spacer()
                
                // The unread indicator is now the primary way to show new notifications.
                if !notification.isRead {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.appPurple)
                }
            }
            
            // The action buttons are now indented to align with the message text.
            if notification.type == .invite {
                actionButtons
                    .padding(.leading, 56) // Aligns with avatar width + spacing
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
    }
    
    // MARK: - Private Views
    
    private var userAvatar: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 44, height: 44)
                .foregroundColor(.appTextTertiary)
            
            Image(systemName: notificationTypeIcon)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(notificationTypeColor)
                .padding(4)
                .background(Color.appBackground.clipShape(Circle()))
                .overlay(Circle().stroke(Color.appBackground, lineWidth: 2))
        }
    }
    
    private var messageText: some View {
        // The VStack helps wrap the text content neatly.
        VStack(alignment: .leading, spacing: 2) {
            Text(notification.user.name)
                .fontWeight(.semibold)
                .foregroundColor(.appTextPrimary)
            +
            Text(" \(notification.message)")
                .foregroundColor(.appTextSecondary)
            
            Text(notification.time)
                .font(.caption)
                .foregroundColor(.appTextTertiary)
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: 12) {
            Button(action: { onAction?(.accept) }) {
                Text("Accept")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .background(Color.appPurple)
                    .cornerRadius(8)
            }
            
            Button(action: { onAction?(.decline) }) {
                Text("Decline")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundColor(.appTextPrimary)
                    .background(Color.appUIElementBackground)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.appBorder))
            }
        }
    }
    
    // MARK: - Computed Properties
    
    private var notificationTypeIcon: String {
        switch notification.type {
        case .like: "heart.fill"
        case .comment: "message.fill"
        case .invite: "person.crop.circle.badge.plus"
        case .post: "camera.fill"
        }
    }
    
    private var notificationTypeColor: Color {
        switch notification.type {
        case .like: .red
        case .comment: .blue
        case .invite: .green
        case .post: .appPurple
        }
    }
}

// MARK: - Previews
#Preview {
    List {
        NotificationRowView(notification: Notification.mockData[2]) // Unread Invite
        NotificationRowView(notification: Notification.mockData[0]) // Unread Like
        NotificationRowView(notification: Notification.mockData[3]) // Read Post
    }
    .listStyle(.plain)
}
