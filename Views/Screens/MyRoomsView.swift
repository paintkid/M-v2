import SwiftUI

struct MyRoomsView: View {
    @State private var rooms: [Room] = Room.mockData

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // MARK: - Header
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("My Rooms")
                            .font(.largeTitle).bold()
                            .foregroundColor(.white)

                        Spacer()

                        Button(action: {
                            print("Create room tapped")
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.purple)
                                .clipShape(Circle())
                        }
                    }

                    Text("Your active habit challenges")
                        .font(.subheadline)
                        .foregroundColor(Color(white: 0.6))
                }
                .padding()
                .background(Color.black)

                // MARK: - Rooms List
                ScrollView {
                    if rooms.isEmpty {
                        emptyStateView
                    } else {
                        LazyVStack(spacing: 12) {
                            ForEach(rooms) { room in
                                RoomRowView(room: room)
                                    .onTapGesture {
                                        print("Tapped on room: \(room.name)")
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

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.3.fill")
                .font(.system(size: 40))
                .foregroundColor(Color(white: 0.5))
                .padding(24)
                .background(Color(white: 0.2).clipShape(Circle()))

            Text("No rooms yet")
                .font(.title2).bold()
                .foregroundColor(.white)

            Text("Create your first room or join one to start building habits with friends.")
                .font(.subheadline)
                .foregroundColor(Color(white: 0.6))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Button(action: {
                print("Create Your First Room tapped")
            }) {
                Text("Create Your First Room")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(Color.purple)
                    .clipShape(Capsule())
            }
            .padding(.top)
        }
        .padding(.top, 80)
    }
}

#Preview {
    MyRoomsView()
}
