import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    /// ContentView now receives the single SessionManager instance from the environment.
    @EnvironmentObject private var sessionManager: SessionManager
    
    // MARK: - Body
    
    var body: some View {
        // This logic is now much simpler and more reliable.
        // We directly check the state of the environment object.
        if sessionManager.currentUser != nil {
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
