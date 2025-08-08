import SwiftUI

struct EditProfileView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: EditProfileViewModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Init
    
    init(user: User) {
        _viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 24) {
                formFields
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { navigationToolbar }
        .overlay(loadingOverlay)
    }
    
    // MARK: - Private Views
    
    private var formFields: some View {
        VStack(spacing: 16) {
            TextField("Name", text: $viewModel.name)
                .textContentType(.name)
            
            VStack(alignment: .leading) {
                TextField("Username", text: $viewModel.username)
                    .textContentType(.username)
                    .autocapitalization(.none)
                
                validationMessage
            }
            
            VStack(alignment: .leading) {
                Text("Bio")
                    .font(.caption)
                    .foregroundColor(.appTextSecondary)
                    .padding(.horizontal, 4)
                
                TextEditor(text: $viewModel.bio)
                    .frame(height: 100)
                    .padding(10)
                    .background(Color.appUIElementBackground)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.appBorder, lineWidth: 1)
                    )
                
                Text("\(viewModel.bio.count) / \(viewModel.bioCharacterLimit)")
                    .font(.caption)
                    .foregroundColor(.appTextSecondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .textFieldStyle(AppTextFieldStyle())
    }
    
    @ViewBuilder
    private var validationMessage: some View {
        HStack {
            Group {
                switch viewModel.usernameValidationState {
                case .unchanged:
                    EmptyView() // Don't show a message if unchanged or empty
                case .checking:
                    ProgressView()
                    Text("Checking availability...")
                case .available:
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Username is available!")
                case .unavailable(let message), .invalid(let message):
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                    Text(message)
                }
            }
            .font(.caption)
            .foregroundColor(.appTextSecondary)
            
            Spacer()
        }
        .frame(height: 20)
    }
    
    @ToolbarContentBuilder
    private var navigationToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Cancel") {
                dismiss()
            }
            .tint(.appPurple)
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Save") {
                handleSaveChanges()
            }
            .tint(.appPurple)
            .fontWeight(.semibold)
            .disabled(viewModel.usernameValidationState == .checking || viewModel.usernameValidationState == .invalid("") || viewModel.usernameValidationState == .unavailable(""))
        }
    }
    
    @ViewBuilder
    private var loadingOverlay: some View {
        if viewModel.isLoading {
            ZStack {
                Color(white: 0, opacity: 0.75)
                ProgressView().tint(.white)
            }
            .ignoresSafeArea()
        }
    }
    
    // MARK: - Private Methods
    
    private func handleSaveChanges() {
        Task {
            let success = await viewModel.saveChanges()
            if success {
                dismiss()
            }
        }
    }
}

// MARK: - Previews
#Preview {
    NavigationStack {
        EditProfileView(user: User.mock)
    }
}
