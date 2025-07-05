import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var sessionManager: SessionManager
    
    // MARK: - Body
    
    var body: some View {
        // Corrected: The logic now checks for the presence of a userUID,
        // which matches the updated SessionManager.
        if sessionManager.userUID != nil {
            AppTabView()
        } else {
            WelcomeView()
        }
    }
}

// MARK: - Previews
#Preview {
    // For the preview to work, we must provide a sample SessionManager.
    ContentView()
        .environmentObject(SessionManager())
}
