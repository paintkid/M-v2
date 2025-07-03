import SwiftUI

struct AppTabView: View {
    
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
            
            // TODO: Create the ProfileView and add it here.
            Text("Profile Screen")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        // TODO: Customize the tab bar appearance to match theme.
        .tint(.appPurple)
    }
}

// MARK: - Previews
#Preview {
    AppTabView()
}
