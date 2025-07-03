import Foundation

/// Manages the state and logic for the MyRooms screen.
@MainActor
class MyRoomsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var rooms: [Room] = []
    
    // MARK: - Init
    
    init() {
        loadRooms()
    }
    
    // MARK: - Private Methods
    
    private func loadRooms() {
        // TODO: Replace with a network call to fetch the user's rooms.
        self.rooms = Room.mockData
    }
}
