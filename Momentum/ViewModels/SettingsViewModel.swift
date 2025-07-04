import Foundation

/// Manages the state and logic for the Settings screen.
@MainActor
final class SettingsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    // TODO: Connect these properties to a data persistence layer (e.g., UserDefaults or Firestore).
    @Published var pushNotifications: Bool = true
    @Published var emailNotifications: Bool = false
    @Published var privateProfile: Bool = false
    
    // MARK: - Section Data
    
    /// Defines the data for the "Account" settings section.
    let accountItems: [SettingItem] = [
        .init(iconName: "person.fill", title: "Edit Profile", subtitle: "Update your name, bio, and photo"),
        .init(iconName: "camera.fill", title: "Profile Photo", subtitle: "Change your profile picture"),
        .init(iconName: "lock.fill", title: "Change Password", subtitle: "Update your account password")
    ]
    
    /// Defines the data for the "App Preferences" section.
    let appPreferenceItems: [SettingItem] = [
        .init(iconName: "moon.fill", title: "Dark Mode", subtitle: "Always enabled for better focus", showsChevron: false),
        .init(iconName: "globe", title: "Language", subtitle: "English")
    ]
    
    /// Defines the data for the "Support" section.
    let supportItems: [SettingItem] = [
        .init(iconName: "questionmark.circle.fill", title: "Help Center"),
        .init(iconName: "message.fill", title: "Contact Support"),
        .init(iconName: "star.fill", title: "Rate Momentum")
    ]
    
    // MARK: - Public Methods
    
    /// Signs the user out using the SessionManager.
    func signOut(sessionManager: SessionManager) {
        sessionManager.signOut()
    }
}
