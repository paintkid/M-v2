import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = SettingsViewModel()
    @EnvironmentObject private var sessionManager: SessionManager
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            List {
                accountSection
                privacySection
                notificationsSection
                appPreferencesSection
                supportSection
                signOutSection
            }
            .listStyle(.insetGrouped)
            .background(Color.appBackground)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Private Views
    
    private var accountSection: some View {
        Section(header: Text("Account")) {
            ForEach(viewModel.accountItems) { item in
                Button(action: {
                    // TODO: Navigate to the corresponding screen (e.g., Edit Profile)
                    print("\(item.title) tapped")
                }) {
                    SettingRowView(item: item)
                }
            }
        }
    }
    
    private var privacySection: some View {
        Section(header: Text("Privacy & Security")) {
            Toggle(isOn: $viewModel.privateProfile) {
                SettingRowView(item: .init(iconName: "shield.fill", title: "Private Profile", showsChevron: false))
            }
        }
    }
    
    private var notificationsSection: some View {
        Section(header: Text("Notifications")) {
            Toggle(isOn: $viewModel.pushNotifications) {
                SettingRowView(item: .init(iconName: "bell.badge.fill", title: "Push Notifications", showsChevron: false))
            }
            Toggle(isOn: $viewModel.emailNotifications) {
                SettingRowView(item: .init(iconName: "envelope.fill", title: "Email Notifications", showsChevron: false))
            }
        }
    }
    
    private var appPreferencesSection: some View {
        Section(header: Text("App Preferences")) {
            Toggle(isOn: $viewModel.isDarkMode) {
                SettingRowView(item: .init(iconName: "moon.fill", title: "Dark Mode", showsChevron: false))
            }
            
            ForEach(viewModel.appPreferenceItems) { item in
                SettingRowView(item: item)
            }
        }
    }
    
    private var supportSection: some View {
        Section(header: Text("Support")) {
            ForEach(viewModel.supportItems) { item in
                Button(action: {
                    // TODO: Handle navigation or actions for support items
                    print("\(item.title) tapped")
                }) {
                    SettingRowView(item: item)
                }
            }
        }
    }
    
    private var signOutSection: some View {
        Section {
            Button(action: {
                viewModel.signOut(sessionManager: sessionManager)
            }) {
                SettingRowView(item: .init(iconName: "rectangle.portrait.and.arrow.right", title: "Sign Out", showsChevron: false, isDestructive: true))
            }
        }
    }
}

// MARK: - Previews
#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(SessionManager())
    }
}
