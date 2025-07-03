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
                            .padding(.top)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("My Rooms")
                    .font(.largeTitle).bold()
                    .foregroundColor(.appTextPrimary)
                
                Spacer()
                
                Button(action: {
                    // TODO: Present CreateRoomView modally.
                    print("Create room tapped")
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.appPurple)
                        .clipShape(Circle())
                }
            }
            
            Text("Your active habit challenges")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.appBackground)
    }
}

// MARK: - Previews
#Preview {
    MyRoomsView()
}
