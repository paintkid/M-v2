// Views/Components/RoomRowView.swift

import SwiftUI

struct RoomRowView: View {
    let room: Room

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: - Header
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(room.name)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.appTextPrimary) // Changed
                    
                    Text("Last activity: \(room.lastActivity)")
                        .font(.system(size: 13))
                        .foregroundColor(.appTextSecondary) // Changed
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    if room.hasNewActivity {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.appPurple) // Changed
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(.appPurple) // Changed
                        
                        Text("\(room.streak)")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.appTextPrimary) // Changed
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.appUIElementBackground) // Changed
                    .cornerRadius(16)
                }
            }
            
            // MARK: - Progress Bar
            VStack(spacing: 8) {
                HStack {
                    Text("Day \(room.progress.current) of \(room.progress.total)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.appTextPrimary) // Changed
                    
                    Spacer()
                    
                    Text("\(Int(room.progressPercentage * 100))%")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.appTextSecondary) // Changed
                }
                
                ProgressView(value: room.progressPercentage, total: 1.0)
                    .tint(.appPurple) // Changed
                    .background(Color.appUIElementBackground) // Changed
                    .scaleEffect(x: 1, y: 1.5, anchor: .center)
                    .clipShape(Capsule())
            }
            
            // MARK: - Members Footer
            HStack {
                Image(systemName: "person.2.fill")
                    .foregroundColor(.appTextTertiary) // Changed
                
                HStack(spacing: -12) {
                    ForEach(0..<min(room.memberAvatarUrls.count, 4), id: \.self) { index in
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.appTextTertiary) // Changed
                            .background(Color.appSecondaryBackground) // Changed
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.appSecondaryBackground, lineWidth: 2)) // Changed
                    }
                    
                    if room.memberAvatarUrls.count > 4 {
                        Text("+\(room.memberAvatarUrls.count - 4)")
                            .font(.system(size: 12, weight: .medium))
                            .frame(width: 32, height: 32)
                            .background(Color.appUIElementBackground) // Changed
                            .foregroundColor(.appTextPrimary) // Changed
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.appSecondaryBackground, lineWidth: 2)) // Changed
                    }
                }
                
                Spacer()
                
                Image(systemName: "calendar")
                    .foregroundColor(.appTextTertiary) // Changed
            }
        }
        .padding()
        .background(Color.appSecondaryBackground) // Changed
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appBorder, lineWidth: 1) // Changed
        )
    }
}

#Preview("Light") {
    ScrollView {
        VStack {
            RoomRowView(room: Room.mockData[0])
            RoomRowView(room: Room.mockData[1])
        }
        .padding()
    }
    .background(Color.appBackground) // Changed
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    ScrollView {
        VStack {
            RoomRowView(room: Room.mockData[0])
            RoomRowView(room: Room.mockData[1])
        }
        .padding()
    }
    .background(Color.appBackground) // Changed
    .preferredColorScheme(.dark)
}
