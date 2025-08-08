import SwiftUI

/// A reusable style for text fields throughout the app.
struct AppTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.appUIElementBackground)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.appBorder, lineWidth: 1)
            )
    }
}
