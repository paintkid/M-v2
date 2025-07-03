// Views/Main/ContentView.swift

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @StateObject private var sessionManager = SessionManager()
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            if sessionManager.currentUser != nil {
                AppTabView()
            } else {
                WelcomeView()
            }
        }
        .environmentObject(sessionManager)
    }
}

// MARK: - Previews
#Preview {
    ContentView()
}
