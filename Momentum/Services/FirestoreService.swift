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
    func createUserDocument(user: User) throws {
        let userRef = db.collection("users").document(user.uid)
        try userRef.setData(from: user)
        print("Successfully created user document for UID: \(user.uid)")
    }
    
    /// Fetches a user document from Firestore.
    /// - Parameter uid: The unique ID of the user to fetch.
    /// - Throws: An error if the document is not found or fails to decode.
    /// - Returns: The decoded User object.
    func fetchUser(withID uid: String) async throws -> User {
        let userRef = db.collection("users").document(uid)
        // The getDocument(as:) method is now part of the main FirebaseFirestore library.
        return try await userRef.getDocument(as: User.self)
    }
}
