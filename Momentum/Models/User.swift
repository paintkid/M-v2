import Foundation
import FirebaseAuth

/// Represents a basic authenticated user provided by Firebase.
struct User {
    let uid: String
    let email: String?
    
    /// Initializes a `User` from a Firebase `AuthDataResult` object.
    init(from authResult: AuthDataResult) {
        self.uid = authResult.user.uid
        self.email = authResult.user.email
    }
    
    /// Initializes a `User` from a Firebase `User` object.
    init(from firebaseUser: FirebaseAuth.User) {
        self.uid = firebaseUser.uid
        self.email = firebaseUser.email
    }
}
