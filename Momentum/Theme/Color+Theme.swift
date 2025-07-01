import SwiftUI

extension Color {

    // MARK: - App-Specific Colors
    static let appPurple = Color("appPurple")
    static let appBackground = Color("appBackground")
    static let appSecondaryBackground = Color("appSecondaryBackground")

    // MARK: - Text Colors
    static let appTextPrimary = Color("appTextPrimary")
    static let appTextSecondary = Color("appTextSecondary")
    static let appTextTertiary = Color("appTextTertiary")

    // MARK: - UI Element Colors
    static let appBorder = Color("appBorder")
    static let appUIElementBackground = Color("appUIElementBackground")
}

struct ColorTheme_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("App Color Palette")
                .font(.largeTitle)
                .padding()
            
            VStack(alignment: .leading) {
                Text("Primary Colors").font(.headline)
                HStack {
                    Color.appPurple.frame(height: 40)
                    Color.appBackground.frame(height: 40).border(Color.gray)
                    Color.appSecondaryBackground.frame(height: 40).border(Color.gray)
                }
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Text Colors").font(.headline)
                Text("Primary Text").foregroundColor(Color.appTextPrimary)
                Text("Secondary Text").foregroundColor(Color.appTextSecondary)
                Text("Tertiary Text").foregroundColor(Color.appTextTertiary)
            }
            .padding()
            .background(Color.appSecondaryBackground)
        }
        .previewLayout(.sizeThatFits)
    }
}
