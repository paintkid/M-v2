import SwiftUI

/// A reusable text field component with a leading icon.
struct IconTextField: View {
    
    // MARK: - Properties
    
    let iconName: String
    let placeholder: String
    @Binding var text: String
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: iconName)
                .foregroundColor(.appTextTertiary)
                .frame(width: 44, height: 44)
            
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .padding(.trailing)
        }
        .background(Color.appUIElementBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appBorder, lineWidth: 1)
        )
    }
}

/// A reusable secure text field component with a leading icon and a show/hide button.
struct SecureIconTextField: View {
    
    // MARK: - Properties
    
    let iconName: String
    let placeholder: String
    @Binding var text: String
    @State private var isSecure = true
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: iconName)
                .foregroundColor(.appTextTertiary)
                .frame(width: 44, height: 44)
            
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .autocapitalization(.none)
            
            Button(action: { isSecure.toggle() }) {
                Image(systemName: isSecure ? "eye.slash" : "eye")
                    .foregroundColor(.appTextTertiary)
                    .frame(width: 44, height: 44)
            }
        }
        .background(Color.appUIElementBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appBorder, lineWidth: 1)
        )
    }
}

// MARK: - Previews
#Preview {
    VStack(spacing: 20) {
        IconTextField(iconName: "person.fill", placeholder: "Full Name", text: .constant(""))
        IconTextField(iconName: "envelope.fill", placeholder: "Email", text: .constant(""))
        SecureIconTextField(iconName: "lock.fill", placeholder: "Password", text: .constant(""))
    }
    .padding()
    .background(Color.appBackground)
}
