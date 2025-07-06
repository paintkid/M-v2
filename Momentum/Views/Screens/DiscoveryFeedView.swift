import SwiftUI

/// A screen that displays a feed of success stories from the community.
struct DiscoveryFeedView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = DiscoveryFeedViewModel()
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // This header is now fixed at the top.
                header
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.journeys) { journey in
                            JourneyCardView(
                                journey: journey,
                                isApplauded: viewModel.applaudedJourneyIDs.contains(journey.id)
                            ) {
                                viewModel.toggleApplaud(for: journey.id)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Corrected: Font size is now smaller and consistent.
            Text("Discovery")
                .font(.title2).bold()
                .foregroundColor(.appTextPrimary)
            
            Text("Success stories from our community")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.appBackground)
    }
}

// MARK: - Previews
#Preview {
    DiscoveryFeedView()
}
