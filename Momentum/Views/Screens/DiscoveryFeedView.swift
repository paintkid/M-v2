// Views/Screens/DiscoveryFeedView.swift

import SwiftUI

/// A screen that displays a feed of success stories from the community.
struct DiscoveryFeedView: View {
    
    // MARK: - Properties
    
    /// The source of truth for the journeys displayed in the feed.
    @State private var journeys: [Journey] = Journey.mockData
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // MARK: - Background
            Color.appBackground.ignoresSafeArea()
            
            // MARK: - Main Content
            VStack(spacing: 0) {

                header
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(journeys) { journey in
                            JourneyCardView(journey: journey)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    /// The custom header view for the Discovery screen.
    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Discovery")
                .font(.largeTitle).bold()
                .foregroundColor(.appTextPrimary)
            
            Text("Success stories from our community")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.appBackground) // Ensures header scrolls over a solid color.
    }
}

// MARK: - Previews
#Preview("Light Mode") {
    DiscoveryFeedView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    DiscoveryFeedView()
        .preferredColorScheme(.dark)
}
