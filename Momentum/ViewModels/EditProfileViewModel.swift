import Foundation
import Combine

/// Manages the state and logic for the Edit Profile screen.
@MainActor
final class EditProfileViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var name: String
    @Published var username: String
    @Published var bio: String
    
    @Published var usernameValidationState: ValidationState = .unchanged
    @Published var isLoading = false
    @Published var error: String?
    
    enum ValidationState: Equatable {
        case unchanged
        case checking
        case available
        case unavailable(String)
        case invalid(String)
    }
    
    // MARK: - Properties
    
    private let user: User
    private var cancellables = Set<AnyCancellable>()
    let bioCharacterLimit = 150
    
    // MARK - Init
    
    init(user: User) {
        self.user = user
        self.name = user.name
        self.username = user.username ?? ""
        self.bio = user.bio
        
        setupSubscribers()
    }
    
    // MARK: - Public Methods
    
    func saveChanges() async -> Bool {
        // The save button should be disabled if the username is invalid.
        guard usernameValidationState != .unavailable(""),
              usernameValidationState != .invalid(""),
              usernameValidationState != .checking else {
            return false
        }
        
        isLoading = true
        defer { isLoading = false }
        
        let updatedData: [String: Any] = [
            "name": name,
            "username": username,
            "bio": bio
        ]
        
        do {
            try await FirestoreService.shared.updateUserDocument(uid: user.uid, data: updatedData)
            print("Successfully updated user profile.")
            return true
        } catch {
            self.error = "Could not save profile. Please try again."
            print("Error updating user profile: \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - Private Methods
    
    private func setupSubscribers() {
        // This subscriber enforces the character limit on the bio.
        $bio
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                if text.count > self.bioCharacterLimit {
                    self.bio = String(text.prefix(self.bioCharacterLimit))
                }
            }
            .store(in: &cancellables)
        
        // This subscriber validates the username after the user stops typing.
        $username
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { [weak self] currentUsername -> AnyPublisher<ValidationState, Never> in
                guard let self = self else { return Just(.unchanged).eraseToAnyPublisher() }
                
                // If the username hasn't changed, we don't need to check it.
                if currentUsername == self.user.username {
                    return Just(.unchanged).eraseToAnyPublisher()
                }
                
                return self.validate(username: currentUsername)
            }
            .assign(to: \.usernameValidationState, on: self)
            .store(in: &cancellables)
    }
    
    private func validate(username: String) -> AnyPublisher<ValidationState, Never> {
        guard !username.isEmpty else {
            return Just(.invalid("Username cannot be empty.")).eraseToAnyPublisher()
        }
        if username.count < 3 {
            return Just(.invalid("Username must be at least 3 characters.")).eraseToAnyPublisher()
        }
        
        DispatchQueue.main.async {
            self.usernameValidationState = .checking
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
