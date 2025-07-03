import SwiftUI
import FirebaseCore

@main
struct MomentumApp: App {
    
    init() {
        FirebaseApp.configure()
        print("Firebase configured successfully!")
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView() // Changed
        }
    }
}
