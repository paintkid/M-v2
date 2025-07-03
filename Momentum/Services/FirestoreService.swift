import Foundation
import FirebaseFirestore

/// A service class responsible for all Cloud Firestore operations.
final class FirestoreService {
    
    // MARK: - Properties
    
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
    
    // MARK: - Private Init
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Creates a new user document in Firestore after sign-up.
    /// - Parameter user: The user object to be saved.
    /// - Throws: An error if the document fails to write.
    func createUserDocument(user: User) async throws {
        let userRef = db.collection("users").document(user.uid)
        try await userRef.setData(from: user)
        print("Successfully created user document for UID: \(user.uid)")
    }
}
