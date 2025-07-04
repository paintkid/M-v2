import Foundation

/// Manages the state and logic for the Settings screen.
@MainActor
final class SettingsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    // TODO: Connect these properties to a data persistence layer (e.g., UserDefaults or Firestore).
    @Published var pushNotifications: Bool = true
    @Published var emailNotifications: Bool = false
    @Published var privateProfile: Bool = false
    @Published var isDarkMode: Bool = true
    
    // MARK: - Section Data
    
    let accountItems: [SettingItem] = [
        .init(iconName: "person.fill", title: "Edit Profile", subtitle: "Update your name, bio, and photo"),
        .init(iconName: "camera.fill", title: "Profile Photo", subtitle: "Change your profile picture"),
        .init(iconName: "lock.fill", title: "Change Password", subtitle: "Update your account password")
    ]
    
    let appPreferenceItems: [SettingItem] = [
        .init(iconName: "globe", title: "Language", subtitle: "English")
    ]
    
    // Updated: Removed Help Center and Contact Support for a later version
    let supportItems: [SettingItem] = [
        .init(iconName: "star.fill", title: "Rate Momentum")
    ]
    
    // MARK: - Public Methods
    
    func signOut(sessionManager: SessionManager) {
        sessionManager.signOut()
    }
}
