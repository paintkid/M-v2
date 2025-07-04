import Foundation

/// Represents a single completed habit or challenge.
struct Accomplishment: Identifiable, Codable {
    let id: String
    let title: String
    let finalPhotoURL: String
    let completedDate: String
}
