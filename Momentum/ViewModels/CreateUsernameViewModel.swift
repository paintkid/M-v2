import Foundation
import Combine

/// Manages the state and logic for the Create Username screen.
@MainActor
final class CreateUsernameViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var username = ""
    @Published var validationState: ValidationState = .empty
    @Published var isLoading = false
    
    /// Defines the possible states for username validation.
    /// Conforming to `Equatable` allows us to compare states (e.g., `validationState == .available`).
    enum ValidationState: Equatable {
        case empty
        case checking
        case available
        case unavailable(String) // Includes a message
        case invalid(String)     // Includes a message
    }
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init() {
        setupUsernameValidationDebounce()
    }
    
    // MARK: - Public Methods
    
    /// Submits the chosen username to Firestore to complete the user's profile.
    /// - Parameter uid: The unique ID of the user whose profile is being updated.
    /// - Returns: A boolean indicating if the operation was successful.
    func completeProfileCreation(forUID uid: String) async -> Bool {
        guard validationState == .available else { return false }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await FirestoreService.shared.updateUsername(forUID: uid, to: username)
            return true
        } catch {
            validationState = .unavailable("Could not save username. Please try again.")
            print("Error updating username: \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - Private Methods
    
    /// Sets up a subscriber that validates the username after the user stops typing.
    private func setupUsernameValidationDebounce() {
        $username
            // Wait for 500ms after the user stops typing.
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            // Remove duplicates to avoid unnecessary checks.
            .removeDuplicates()
            // Switch to the validation logic.
            .flatMap { [weak self] currentUsername -> AnyPublisher<ValidationState, Never> in
                guard let self = self else {
                    return Just(.empty).eraseToAnyPublisher()
                }
                return self.validate(username: currentUsername)
            }
            // Assign the result to our state property.
            .assign(to: \.validationState, on: self)
            .store(in: &cancellables)
    }
    
    /// Performs validation and availability checks on the provided username.
    private func validate(username: String) -> AnyPublisher<ValidationState, Never> {
        guard !username.isEmpty else {
            return Just(.empty).eraseToAnyPublisher()
        }
        
        // TODO: Implement more robust username validation rules (e.g., no special characters).
        if username.count < 3 {
            return Just(.invalid("Username must be at least 3 characters.")).eraseToAnyPublisher()
        }
        
        // We set the state to checking immediately for instant UI feedback.
        DispatchQueue.main.async {
            self.validationState = .checking
        }
        
        return Future<ValidationState, Never> { promise in
            Task {
                do {
                    let isAvailable = try await FirestoreService.shared.checkUsernameAvailability(username: username)
                    if isAvailable {
                        promise(.success(.available))
                    } else {
                        promise(.success(.unavailable("Username is already taken.")))
                    }
                } catch {
                    promise(.success(.unavailable("Error checking username.")))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
