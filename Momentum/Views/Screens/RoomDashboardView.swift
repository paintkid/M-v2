import SwiftUI

/// A placeholder screen for a room's detailed dashboard.
struct RoomDashboardView: View {
    
    // MARK: - Properties
    
    let room: Room
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            Text(room.name)
                .font(.largeTitle)
                .foregroundColor(.appTextPrimary)
        }
        .navigationTitle(room.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Previews
#Preview {
    // To make the preview work, we wrap it in a NavigationStack.
    NavigationStack {
        RoomDashboardView(room: Room.mockData[0])
    }
}
