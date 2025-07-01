import SwiftUI

struct RoomRowView: View {
    
    let room: Room

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: - Header
            HStack(alignment: .top) {
                // Room Name and Last Activity
                VStack(alignment: .leading, spacing: 4) {
                    Text(room.name)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)

                    Text("Last activity: \(room.lastActivity)")
                        .font(.system(size: 13))
                        .foregroundColor(Color(white: 0.6))
                }

                Spacer()

                // New Activity Dot and Streak
                HStack(spacing: 12) {
                    if room.hasNewActivity {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color.purple)
                    }

                    HStack(spacing: 4) {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(.purple)

                        Text("\(room.streak)")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(white: 0.2))
                    .cornerRadius(16)
                }
            }

            // MARK: - Progress Bar
            VStack(spacing: 8) {
                HStack {
                    Text("Day \(room.progress.current) of \(room.progress.total)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(white: 0.8))

                    Spacer()

                    Text("\(Int(room.progressPercentage * 100))%")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(white: 0.5))
                }

                ProgressView(value: room.progressPercentage, total: 1.0)
                    .tint(.purple)
                    .background(Color(white: 0.2))
                    .scaleEffect(x: 1, y: 1.5, anchor: .center) // Makes the bar thicker
                    .clipShape(Capsule())
            }

            // MARK: - Members Footer
            HStack {
                Image(systemName: "person.2.fill")
                    .foregroundColor(Color(white: 0.5))

                HStack(spacing: -12) {
                    ForEach(0..<min(room.memberAvatarUrls.count, 4), id: \.self) { index in
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                            .background(Color(white: 0.1))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(white: 0.1), lineWidth: 2))
                    }

                    if room.memberAvatarUrls.count > 4 {
                        Text("+\(room.memberAvatarUrls.count - 4)")
                            .font(.system(size: 12, weight: .medium))
                            .frame(width: 32, height: 32)
                            .background(Color(white: 0.3))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(white: 0.1), lineWidth: 2))
                    }
                }

                Spacer()

                Image(systemName: "calendar")
                    .foregroundColor(Color(white: 0.4))
            }
        }
        .padding()
        .background(Color(white: 0.15))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(white: 0.25), lineWidth: 1)
        )
    }
}

#Preview {
    ScrollView {
        VStack {
            RoomRowView(room: Room.mockData[0])
            RoomRowView(room: Room.mockData[1])
        }
        .padding()
    }
    .background(Color.black)
}
