import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var sessionManager: SessionManager
    @StateObject private var viewModel: ProfileViewModel
    
    // MARK: - Init
    
    init() {
        let uid = Auth.auth().currentUser?.uid ?? ""
        _viewModel = StateObject(wrappedValue: ProfileViewModel(userUID: uid))
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    header
                    
                    ScrollView {
                        if let user = viewModel.user {
                            VStack(spacing: 24) {
                                profileDetails(for: user)
                                statsSection(for: user.stats ?? .init(roomsCompleted: 0, totalDays: 0, currentStreak: 0))
                                accomplishmentsSection
                            }
                            .padding(.vertical)
                        } else {
                            ProgressView()
                                .frame(maxHeight: .infinity)
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchUserProfile()
                    viewModel.loadAccomplishments()
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    private var header: some View {
        HStack(alignment: .center) {
            Text("Profile")
                .font(.title2).bold()
                .foregroundColor(.appTextPrimary)
            
            Spacer()
            
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 22))
                    .foregroundColor(.appTextSecondary)
            }
        }
        .padding()
        .background(Color.appBackground)
    }
    
    private func profileDetails(for user: User) -> some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.appTextTertiary)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.title2).bold()
                        .foregroundColor(.appTextPrimary)
                    
                    Text(user.username ?? "No username")
                        .font(.subheadline)
                        .foregroundColor(.appTextSecondary)
                    
                    Text(user.bio)
                        .font(.subheadline)
                        .foregroundColor(.appTextSecondary)
                        .padding(.top, 4)
                }
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
        .padding(.horizontal)
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
}

// MARK: - Previews
#Preview {
    ProfileView()
        .environmentObject(SessionManager())
}
