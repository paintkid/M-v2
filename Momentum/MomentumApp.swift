import SwiftUI
import FirebaseCore

@main
struct MomentumApp: App {
    
    // MARK: - Properties
    
    /// The SessionManager is now created here, once, as a StateObject.
    /// It will live for the entire duration of the app.
    @StateObject private var sessionManager = SessionManager()
    
    // MARK: - Init
    
    init() {
        FirebaseApp.configure()
        print("Firebase configured successfully!")
    }
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // We pass the single instance of the sessionManager into the
                // environment for all child views to access.
                .environmentObject(sessionManager)
        }
    }
}
