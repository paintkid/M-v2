
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
        VStack(spacing: 10) {
            Text("App Colors").font(.largeTitle).bold()
            
            VStack(alignment: .leading) {
                Text("Backgrounds").font(.headline)
                HStack {
                    Color.appBackground.frame(width: 50, height: 50).border(Color.gray)
                    Color.appSecondaryBackground.frame(width: 50, height: 50).border(Color.gray)
                    Color.appUIElementBackground.frame(width: 50, height: 50).border(Color.gray)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Accents").font(.headline)
                HStack {
                    Color.appPurple.frame(width: 50, height: 50)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Text & Borders").font(.headline)
                Text("Primary Text").foregroundColor(.appTextPrimary)
                Text("Secondary Text").foregroundColor(.appTextSecondary)
                Text("Tertiary Text").foregroundColor(.appTextTertiary)
                Divider().background(Color.appBorder)
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)
        .previewDisplayName("Light Mode")
        
        VStack(spacing: 10) {
            Text("App Colors").font(.largeTitle).bold()
            
            VStack(alignment: .leading) {
                Text("Backgrounds").font(.headline)
                HStack {
                    Color.appBackground.frame(width: 50, height: 50).border(Color.gray)
                    Color.appSecondaryBackground.frame(width: 50, height: 50).border(Color.gray)
                    Color.appUIElementBackground.frame(width: 50, height: 50).border(Color.gray)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Accents").font(.headline)
                HStack {
                    Color.appPurple.frame(width: 50, height: 50)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Text & Borders").font(.headline)
                Text("Primary Text").foregroundColor(.appTextPrimary)
                Text("Secondary Text").foregroundColor(.appTextSecondary)
                Text("Tertiary Text").foregroundColor(.appTextTertiary)
                Divider().background(Color.appBorder)
            }
        }
        .padding()
        .background(Color.black)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
        .previewDisplayName("Dark Mode")
    }
}
