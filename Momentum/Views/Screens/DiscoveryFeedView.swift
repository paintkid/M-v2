// Views/Screens/DiscoveryFeedView.swift

import SwiftUI

struct DiscoveryFeedView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = DiscoveryFeedViewModel()
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
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
                    .padding(.top)
                }
            }
        }
    }
    
    // MARK: - Private Views
    
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
        .background(Color.appBackground)
    }
}

// MARK: - Previews
#Preview {
    DiscoveryFeedView()
}
