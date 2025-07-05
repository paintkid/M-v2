import SwiftUI

struct AppTabView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var sessionManager: SessionManager
    
    // MARK: - Body
    
    var body: some View {
        TabView {
            DiscoveryFeedView()
                .tabItem {
                    Label("Discovery", systemImage: "sparkles")
                }
            
            MyRoomsView()
                .tabItem {
                    Label("My Rooms", systemImage: "person.2.fill")
                }
            
            NotificationsView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
            
            // Corrected: The ProfileView now takes no arguments.
            // It manages its own state by creating its own ViewModel.
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .tint(.appPurple)
    }
}

// MARK: - Previews
#Preview {
    AppTabView()
        .environmentObject(SessionManager())
}
