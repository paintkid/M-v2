// Views/Screens/Profile/ProfileView.swift

import SwiftUI

struct ProfileView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: ProfileViewModel
    
    // MARK: - Init
    
    init(user: User?) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        if let user = viewModel.user {
                            profileHeader(for: user)
                            
                            statsSection(for: user.stats)
                            
                            accomplishmentsSection
                        } else {
                            ProgressView()
                        }
                    }
                }
            }
            .toolbar { navigationToolbar }
        }
    }
    
    // MARK: - Private Views
    
    private func profileHeader(for user: User) -> some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.appTextTertiary)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.title2).bold()
                        .foregroundColor(.appTextPrimary)
                    
                    Text(user.username)
                        .font(.subheadline)
                        .foregroundColor(.appTextSecondary)
                    
                    Text(user.bio)
                        .font(.subheadline)
                        .foregroundColor(.appTextSecondary)
                        .padding(.top, 4)
                }
                // This ensures the text content aligns to the left.
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Button(action: {
                // TODO: Navigate to Edit Profile screen
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "pencil")
                    Text("Edit Profile")
                }
                .font(.system(size: 14, weight: .semibold))
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding()
    }
    
    private func statsSection(for stats: User.Stats) -> some View {
        VStack(spacing: 0) {
            Divider().background(Color.appBorder)
            HStack {
                Spacer()
                StatItemView(iconName: "trophy.fill", value: "\(stats.roomsCompleted)", label: "Rooms Completed")
                Spacer()
                StatItemView(iconName: "calendar", value: "\(stats.totalDays)", label: "Total Days")
                Spacer()
                StatItemView(iconName: "bolt.fill", value: "\(stats.currentStreak)", label: "Current Streak")
                Spacer()
            }
            .padding(.vertical, 16)
            Divider().background(Color.appBorder)
        }
    }
    
    private var accomplishmentsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Accomplishments")
                .font(.title2).bold()
                .foregroundColor(.appTextPrimary)
                .padding(.horizontal)
            
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)], spacing: 12) {
                ForEach(viewModel.accomplishments) { accomplishment in
                    AccomplishmentCardView(accomplishment: accomplishment)
                }
            }
            .padding(.horizontal)
        }
    }
    
    @ToolbarContentBuilder
    private var navigationToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Text("Profile")
                .font(.largeTitle).bold()
                .foregroundColor(.appTextPrimary)
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            // TODO: Replace with NavigationLink to SettingsView
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.appTextSecondary)
            }
        }
    }
}

// MARK: - Previews
#Preview {
    let mockUser = User(
        uid: "123",
        email: "preview@example.com",
        name: "Alex Johnson"
    )
    
    return ProfileView(user: mockUser)
        .environmentObject(SessionManager())
}
