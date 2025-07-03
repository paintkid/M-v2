import SwiftUI

struct WelcomeView: View {
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        heroSection
                            .padding(.bottom, 48)
                        
                        featuresSection
                            .padding(.bottom, 48)
                        
                        ctaButtons
                        
                        footer
                            .padding(.top, 32)
                    }
                    .padding()
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    private var heroSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "bolt.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
                .background(Color.appPurple.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous)))
            
            VStack {
                Text("Momentum")
                    .font(.largeTitle).bold()
                    .foregroundColor(.appTextPrimary)
                
                Text("Build habits with friends")
                    .font(.title3)
                    .foregroundColor(.appTextSecondary)
            }
        }
    }
    
    private var featuresSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            FeatureRow(
                iconName: "person.2.fill",
                title: "Social Accountability",
                subtitle: "Join private rooms with friends for motivation"
            )
            
            FeatureRow(
                iconName: "target",
                title: "Daily Progress",
                subtitle: "Share photos and track your journey"
            )
            
            FeatureRow(
                iconName: "trophy.fill",
                title: "Celebrate Success",
                subtitle: "Share your achievements with the community"
            )
        }
    }
    
    private var ctaButtons: some View {
        VStack(spacing: 16) {
            NavigationLink(destination: SignUpView()) {
                Text("Get Started")
            }
            .buttonStyle(PrimaryButtonStyle())
            
            NavigationLink(destination: LoginView()) {
                Text("I already have an account")
            }
            .buttonStyle(SecondaryButtonStyle())
        }
    }
    
    private var footer: some View {
        Text("Join thousands building better habits together")
            .font(.caption)
            .foregroundColor(.appTextTertiary)
    }
}

/// A reusable view for displaying a single feature highlight.
private struct FeatureRow: View {
    let iconName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(.appPurple)
                .frame(width: 52, height: 52)
                .background(Color.appUIElementBackground.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous)))
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.appTextPrimary)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.appTextSecondary)
            }
        }
    }
}


// MARK: - Previews
#Preview {
    WelcomeView()
}
