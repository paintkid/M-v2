// Views/Screens/NotificationsView.swift

import SwiftUI

/// A screen that displays a list of user notifications with a modern, seamless style.
struct NotificationsView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = NotificationsViewModel()
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                
                List {
                    if viewModel.notifications.isEmpty {
                        emptyState
                    } else {
                        ForEach(viewModel.notifications) { notification in
                            NotificationRowView(notification: notification) { action in
                                handle(action, for: notification)
                            }
                            .onAppear {
                                viewModel.markAsRead(notificationId: notification.id)
                            }
                            // Key changes for seamless look:
                            .listRowInsets(EdgeInsets()) // No default padding.
                            .listRowSeparatorTint(Color.appBorder) // Themed divider.
                            .background(Color.appBackground) // Ensure row background matches screen.
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    // TODO: Implement logic to re-fetch notifications from the server.
                    print("Refreshing notifications...")
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Notifications")
                .font(.largeTitle).bold()
                .foregroundColor(.appTextPrimary)
            
            Text("Stay updated with your rooms")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.appBackground)
    }
    
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "bell.slash.fill")
                .font(.system(size: 40))
                .foregroundColor(.appTextSecondary)
            
            Text("No New Notifications")
                .font(.title2).bold()
                .foregroundColor(.appTextPrimary)
            
            Text("When people interact with you or your posts, you'll see it here.")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 80)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }
    
    // MARK: - Private Methods
    
    private func handle(_ action: NotificationRowView.Action, for notification: Notification) {
        switch action {
        case .accept:
            viewModel.acceptInvite(for: notification.id)
        case .decline:
            viewModel.declineInvite(for: notification.id)
        }
    }
}

// MARK: - Previews
#Preview("Light Mode") {
    NotificationsView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    NotificationsView()
        .preferredColorScheme(.dark)
}
