// Views/Screens/Profile/Components/AccomplishmentCardView.swift

import SwiftUI

/// A view that displays a single user accomplishment in a card format for a grid.
struct AccomplishmentCardView: View {
    
    // MARK: - Properties
    
    let accomplishment: Accomplishment
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Placeholder for the final photo.
            // TODO: Replace with an async image loader when network service is built.
            Rectangle()
                .fill(Color.appUIElementBackground)
                .aspectRatio(1.0, contentMode: .fill)
            
            // This is the text container.
            VStack(alignment: .leading, spacing: 2) {
                Text(accomplishment.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.appTextPrimary)
                    .lineLimit(2)
                
                Text(accomplishment.completedDate)
                    .font(.caption)
                    .foregroundColor(.appTextSecondary)
                
                // This Spacer pushes the content to the top of the frame,
                // ensuring consistent alignment even if the text is short.
                Spacer(minLength: 0)
            }
            .padding(12)
            // This is the key fix: We enforce a fixed height on the text container.
            // This guarantees that every card's text area is exactly the same size.
            .frame(height: 80)
        }
        .background(Color.appSecondaryBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appBorder, lineWidth: 1)
        )
    }
}

// MARK: - Mock Data for Preview
extension Accomplishment {
    static let mockData: [Accomplishment] = [
        .init(id: "1", title: "30-Day Morning Workout", finalPhotoURL: "", completedDate: "2 weeks ago"),
        .init(id: "2", title: "60-Day Meditation Journey", finalPhotoURL: "", completedDate: "1 month ago"),
        .init(id: "3", title: "21-Day Water Challenge", finalPhotoURL: "", completedDate: "2 months ago"),
        .init(id: "4", title: "90-Day Reading Habit", finalPhotoURL: "", completedDate: "3 months ago"),
    ]
}


// MARK: - Previews
#Preview {
    // Grid to show the cards in their intended layout.
    ScrollView {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(Accomplishment.mockData) { accomplishment in
                AccomplishmentCardView(accomplishment: accomplishment)
            }
        }
        .padding()
    }
    .background(Color.appBackground)
}
