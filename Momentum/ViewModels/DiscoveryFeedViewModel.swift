import Foundation

/// Manages the state and logic for the DiscoveryFeed screen.
@MainActor
class DiscoveryFeedViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var journeys: [Journey] = []
    
    /// A set to keep track of which journeys the user has applauded in the current session.
    @Published private(set) var applaudedJourneyIDs = Set<String>()
    
    // MARK: - Init
    
    init() {
        loadJourneys()
    }
    
    // MARK: - Public Methods
    
    /// Toggles the applauded state for a given journey.
    func toggleApplaud(for journeyId: String) {
        if applaudedJourneyIDs.contains(journeyId) {
            applaudedJourneyIDs.remove(journeyId)
            print("Removed applaud for journey: \(journeyId)")
            // TODO: Send network request to server to remove applaud.
        } else {
            applaudedJourneyIDs.insert(journeyId)
            print("Applauded journey: \(journeyId)")
            // TODO: Send network request to server to add applaud.
        }
    }
    
    // MARK: - Private Methods
    
    private func loadJourneys() {
        // TODO: Replace with a network call to fetch discovery feed journeys.
        self.journeys = Journey.mockData
    }
}
