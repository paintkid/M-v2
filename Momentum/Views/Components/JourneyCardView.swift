// Views/Components/JourneyCardView.swift

import SwiftUI

struct JourneyCardView: View {
    
    // MARK: - Properties
    
    let journey: Journey
    let isApplauded: Bool
    var onApplaud: (() -> Void)?
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            userHeader
            
            Text(journey.title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.appTextPrimary)
                .padding(.horizontal)
                .padding(.bottom, 12)
            
            beforeAfterPhotos
                .padding(.horizontal)
                .padding(.bottom, 16)
            
            Text(journey.summary)
                .font(.system(size: 15))
                .foregroundColor(.appTextSecondary)
                .lineSpacing(4)
                .padding(.horizontal)
                .padding(.bottom, 16)
            
            actionsFooter
        }
        .background(Color.appSecondaryBackground)
        .cornerRadius(16)
    }
    
    // MARK: - Private Views
    
    private var userHeader: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable().frame(width: 40, height: 40).foregroundColor(.appTextTertiary)
            VStack(alignment: .leading) {
                Text(journey.user.name).font(.system(size: 15, weight: .semibold)).foregroundColor(.appTextPrimary)
                Text("\(journey.daysAgo) days ago").font(.system(size: 13)).foregroundColor(.appTextSecondary)
            }
            Spacer()
            Image(systemName: "trophy.fill").foregroundColor(.white).padding(8)
                .background(Color.appPurple.clipShape(Circle()))
        }.padding()
    }
    
    private var beforeAfterPhotos: some View {
        HStack(spacing: 12) {
            photo(label: "Day 1", isFinal: false)
            photo(label: "Final Day", isFinal: true)
        }
    }
    
    private func photo(label: String, isFinal: Bool) -> some View {
        ZStack(alignment: .topLeading) {
            Rectangle().fill(Color.appUIElementBackground).aspectRatio(1.0, contentMode: .fill)
            Text(label).font(.system(size: 12, weight: .medium)).padding(.horizontal, 8).padding(.vertical, 4)
                .background(isFinal ? Color.appPurple.opacity(0.9) : Color.black.opacity(0.7))
                .foregroundColor(.white).cornerRadius(6).padding(8)
        }.cornerRadius(12)
    }
    
    private var actionsFooter: some View {
        VStack(spacing: 0) {
            Divider().background(Color.appBorder)
            
            HStack {
                Text("Encouraged by **\(journey.encouragement.users.first ?? "Someone")** and **\(journey.encouragement.totalCount - 1) others**")
                    .font(.system(size: 13)).foregroundColor(.appTextSecondary)
                
                Spacer()
                
                Button(action: { onApplaud?() }) {
                    Text(isApplauded ? "Applauded" : "Applaud")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.horizontal, 16).padding(.vertical, 8)
                        .background(isApplauded ? Color.appPurple : Color.appUIElementBackground)
                        .foregroundColor(isApplauded ? .white : .appTextPrimary)
                        .clipShape(Capsule())
                }
            }
            .padding()
        }
    }
}

// MARK: - Previews
#Preview {
    ScrollView {
        VStack(spacing: 20) {
            JourneyCardView(journey: Journey.mockData[0], isApplauded: true)
            JourneyCardView(journey: Journey.mockData[1], isApplauded: false)
        }
        .padding()
    }
    .background(Color.appBackground)
}
