//
//  LoginView.swift
//  Momentum
//
//  Created by joel on 7/3/25.
//


// Views/Screens/Authentication/LoginView.swift

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    header
                        .padding(.bottom, 32)
                    
                    socialButtons
                        .padding(.bottom, 24)
                    
                    divider
                        .padding(.bottom, 24)
                    
                    emailForm
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar { navigationToolbar }
        .overlay(loadingOverlay)
    }
    
    // MARK: - Private Views
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome Back")
                .font(.largeTitle).bold()
                .foregroundColor(.appTextPrimary)
            
            Text("Sign in to continue your habit journey.")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var socialButtons: some View {
        VStack(spacing: 16) {
            Button(action: {
                // TODO: Implement Apple Sign In
            }) {
                HStack {
                    Image(systemName: "apple.logo")
                    Text("Continue with Apple")
                }
            }
            .buttonStyle(SecondaryButtonStyle())
            .foregroundColor(.appTextPrimary) // Override for white/black button
            .background(Color.white) // For Apple's branding
            .cornerRadius(16)
            
            Button(action: {
                // TODO: Implement Google Sign In
            }) {
                HStack {
                    // We don't have a Google logo, so use a placeholder
                    Image(systemName: "g.circle.fill")
                    Text("Continue with Google")
                }
            }
            .buttonStyle(SecondaryButtonStyle())
        }
    }
    
    private var divider: some View {
        HStack {
            VStack { Divider().background(Color.appBorder) }
            Text("or")
                .font(.caption)
                .foregroundColor(.appTextTertiary)
            VStack { Divider().background(Color.appBorder) }
        }
    }
    
    private var emailForm: some View {
        VStack(spacing: 16) {
            IconTextField(
                iconName: "envelope.fill",
                placeholder: "Email",
                text: $viewModel.email
            )
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            
            SecureIconTextField(
                iconName: "lock.fill",
                placeholder: "Password",
                text: $viewModel.password
            )
            .textContentType(.password)
            
            if let error = viewModel.error {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Button(action: {
                // TODO: Implement forgot password flow
            }) {
                Text("Forgot password?")
                    .font(.subheadline)
                    .foregroundColor(.appPurple)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Button(action: handleSignIn) {
                Text("Sign In")
            }
            .buttonStyle(PrimaryButtonStyle(isDisabled: !viewModel.isLoginFormValid))
            .disabled(!viewModel.isLoginFormValid)
            .padding(.top)
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
    
    @ToolbarContentBuilder
    private var navigationToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { dismiss() }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.appPurple)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func handleSignIn() {
        Task {
            let success = await viewModel.signIn()
            if success {
                // TODO: Dismiss auth flow and show main app content
                print("Sign in successful")
            }
        }
    }
}

// MARK: - Previews
#Preview {
    NavigationStack {
        LoginView()
    }
}
