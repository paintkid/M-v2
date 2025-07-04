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
                        .foregroundColor(.appTextPrimary)
                    
                    Text("Last activity: \(room.lastActivity)")
                        .font(.system(size: 13))
                        .foregroundColor(.appTextSecondary)
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    if room.hasNewActivity {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.appPurple)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(.appPurple)
                        
                        Text("\(room.streak)")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.appTextPrimary)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.appUIElementBackground)
                    .cornerRadius(16)
                }
            }
            
            // MARK: - Progress Bar
            VStack(spacing: 8) {
                HStack {
                    Text("Day \(room.progress.current) of \(room.progress.total)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.appTextPrimary)
                    
                    Spacer()
                    
                    Text("\(Int(room.progressPercentage * 100))%")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.appTextSecondary)
                }
                
                ProgressView(value: room.progressPercentage, total: 1.0)
                    .tint(.appPurple)
                    .background(Color.appUIElementBackground)
                    .scaleEffect(x: 1, y: 1.5, anchor: .center)
                    .clipShape(Capsule())
            }
            
            // MARK: - Members Footer
            HStack {
                Image(systemName: "person.2.fill")
                    .foregroundColor(.appTextTertiary)
                
                HStack(spacing: -12) {
                    ForEach(0..<min(room.memberAvatarUrls.count, 4), id: \.self) { index in
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.appTextTertiary)
                            .background(Color.appSecondaryBackground)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.appSecondaryBackground, lineWidth: 2))
                    }
                    
                    if room.memberAvatarUrls.count > 4 {
                        Text("+\(room.memberAvatarUrls.count - 4)")
                            .font(.system(size: 12, weight: .medium))
                            .frame(width: 32, height: 32)
                            .background(Color.appUIElementBackground)
                            .foregroundColor(.appTextPrimary)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.appSecondaryBackground, lineWidth: 2))
                    }
                }
                
                Spacer()
                
                Image(systemName: "calendar")
                    .foregroundColor(.appTextTertiary)
            }
        }
        .padding()
        .background(Color.appSecondaryBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appBorder, lineWidth: 1)
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
    .background(Color.appBackground)
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
    .background(Color.appBackground)
    .preferredColorScheme(.dark)
}
