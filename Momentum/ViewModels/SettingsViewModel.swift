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
    
    /// The account section now focuses on core account security.
    let accountItems: [SettingItem] = [
        .init(iconName: "envelope.fill", title: "Update Email", subtitle: "Change your account email address"),
        .init(iconName: "lock.fill", title: "Change Password", subtitle: "Update your account password")
    ]
    
    let appPreferenceItems: [SettingItem] = [
        .init(iconName: "globe", title: "Language", subtitle: "English")
    ]
    
    let supportItems: [SettingItem] = [
        .init(iconName: "star.fill", title: "Rate Momentum")
    ]
    
    // MARK: - Public Methods
    
    func signOut(sessionManager: SessionManager) {
        sessionManager.signOut()
    }
}
