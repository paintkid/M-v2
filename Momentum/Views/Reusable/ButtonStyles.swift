import SwiftUI

/// A reusable style for primary, high-emphasis action buttons.
struct PrimaryButtonStyle: ButtonStyle {
    
    // MARK: - Properties
    
    var isDisabled: Bool = false
    
    // MARK: - Body
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .semibold))
            .padding()
            .frame(maxWidth: .infinity)
            .background(isDisabled ? Color.appUIElementBackground : Color.appPurple)
            .foregroundColor(isDisabled ? .appTextTertiary : .white)
            .cornerRadius(16)
            .scaleEffect(configuration.isPressed && !isDisabled ? 0.98 : 1.0)
    }
}

/// A reusable style for secondary, medium-emphasis action buttons.
struct SecondaryButtonStyle: ButtonStyle {
    
    // MARK: - Body
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .semibold))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.appUIElementBackground)
            .foregroundColor(.appTextPrimary)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.appBorder, lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}
