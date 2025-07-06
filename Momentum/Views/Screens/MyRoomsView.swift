import SwiftUI

struct MyRoomsView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = MyRoomsViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    header
                    
                    ScrollView {
                        if viewModel.rooms.isEmpty {
                            // TODO: Build a proper empty state view.
                            Text("Empty State Placeholder")
                        } else {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.rooms) { room in
                                    NavigationLink(destination: RoomDashboardView(room: room)) {
                                        RoomRowView(room: room)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    private var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("My Rooms")
                    .font(.title2).bold()
                    .foregroundColor(.appTextPrimary)
                
                Text("Your active habit challenges")
                    .font(.subheadline)
                    .foregroundColor(.appTextSecondary)
            }
            
            Spacer()
            
            Button(action: {
                // TODO: Present CreateRoomView modally
                print("Create room tapped")
            }) {
                Image(systemName: "plus")
                    // Corrected: Reduced font size and frame size for a more refined look.
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(Color.appPurple)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color.appBackground)
    }
}

// MARK: - Previews
#Preview {
    MyRoomsView()
}
