import SwiftUI

/// A reusable view for displaying a single row in a settings list.
struct SettingRowView: View {
    
    // MARK: - Properties
    
    let item: SettingItem
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.iconName)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(item.isDestructive ? .red : .appPurple)
                .frame(width: 32, height: 32)
                .background(item.isDestructive ? Color.red.opacity(0.15) : Color.appPurple.opacity(0.15))
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(item.isDestructive ? .semibold : .regular)
                    .foregroundColor(item.isDestructive ? .red : .appTextPrimary)
                
                if let subtitle = item.subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.appTextSecondary)
                }
            }
            
            Spacer()
            
            if item.showsChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.appTextTertiary)
            }
        }
        .padding(.vertical, 8)
    }
}

/// A model representing a single item in a settings list.
struct SettingItem: Identifiable {
    let id = UUID()
    let iconName: String
    let title: String
    let subtitle: String?
    let showsChevron: Bool
    let isDestructive: Bool
    
    init(iconName: String, title: String, subtitle: String? = nil, showsChevron: Bool = true, isDestructive: Bool = false) {
        self.iconName = iconName
        self.title = title
        self.subtitle = subtitle
        self.showsChevron = showsChevron
        self.isDestructive = isDestructive
    }
}


// MARK: - Previews
#Preview {
    List {
        SettingRowView(item: .init(iconName: "person.fill", title: "Edit Profile", subtitle: "Update your name, bio, and photo"))
        SettingRowView(item: .init(iconName: "lock.fill", title: "Change Password"))
        SettingRowView(item: .init(iconName: "rectangle.portrait.and.arrow.right", title: "Sign Out", showsChevron: false, isDestructive: true))
    }
}
