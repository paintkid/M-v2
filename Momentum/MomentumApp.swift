import SwiftUI
import FirebaseCore

@main
struct MomentumApp: App {
    
    // MARK: - Init
    
    init() {
        FirebaseApp.configure()
        print("Firebase configured successfully!")
    }
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            MyRoomsView()
        }
    }
}
