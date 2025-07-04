// Views/Screens/Profile/Components/StatItemView.swift

import SwiftUI

/// A view that displays a single user statistic, such as rooms completed or current streak.
struct StatItemView: View {
    
    // MARK: - Properties
    
    let iconName: String
    let value: String
    let label: String
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: iconName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.appPurple)
                
                Text(value)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.appTextPrimary)
            }
            
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.appTextSecondary)
        }
    }
}

// MARK: - Previews
#Preview {
    HStack(spacing: 20) {
        StatItemView(iconName: "trophy.fill", value: "12", label: "Rooms Completed")
        StatItemView(iconName: "calendar", value: "847", label: "Total Days")
        StatItemView(iconName: "bolt.fill", value: "23", label: "Current Streak")
    }
    .padding()
    .background(Color.appSecondaryBackground)
}
