import Foundation

@MainActor
class DiscoveryFeedViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var journeys: [Journey] = []
    @Published private(set) var applaudedJourneyIDs = Set<String>()
    
    // MARK: - Init
    
    init() {
        loadJourneys()
    }
    
    // MARK: - Public Methods
    
    func toggleApplaud(for journeyId: String) {
        // Find the index of the journey to modify.
        guard let index = journeys.firstIndex(where: { $0.id == journeyId }) else {
            print("Error: Journey with ID \(journeyId) not found.")
            return
        }
        
        if applaudedJourneyIDs.contains(journeyId) {
            applaudedJourneyIDs.remove(journeyId)
            journeys[index].encouragement.totalCount -= 1
            print("Removed applaud for journey: \(journeyId)")
            // TODO: Send network request to server to remove applaud.
        } else {
            applaudedJourneyIDs.insert(journeyId)
            journeys[index].encouragement.totalCount += 1
            print("Applauded journey: \(journeyId)")
            // TODO: Send network request to server to add applaud.
        }
    }
    
    // MARK: - Private Methods
    
    private func loadJourneys() {
        // TODO: Replace mock data with a network call to fetch discovery feed journeys.
        self.journeys = Journey.mockData
    }
}
