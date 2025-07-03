//
//  SignUpView.swift
//  Momentum
//
//  Created by joel on 7/3/25.
//


// Views/Screens/Authentication/SignUpView.swift

import SwiftUI

struct SignUpView: View {
    
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
            Text("Create Account")
                .font(.largeTitle).bold()
                .foregroundColor(.appTextPrimary)
            
            Text("Start building better habits with friends.")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var emailForm: some View {
        VStack(spacing: 16) {
            IconTextField(
                iconName: "person.fill",
                placeholder: "Full Name",
                text: $viewModel.name
            )
            .textContentType(.name)
            
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
            .textContentType(.newPassword)
            
            SecureIconTextField(
                iconName: "lock.fill",
                placeholder: "Confirm Password",
                text: $viewModel.confirmPassword
            )
            .textContentType(.newPassword)
            
            if let error = viewModel.error {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            termsToggle
                .padding(.top)
            
            Button(action: handleSignUp) {
                Text("Create Account")
            }
            .buttonStyle(PrimaryButtonStyle(isDisabled: !viewModel.isSignUpFormValid))
            .disabled(!viewModel.isSignUpFormValid)
            .padding(.top)
        }
    }
    
    private var termsToggle: some View {
        HStack(spacing: 12) {
            Button(action: { viewModel.acceptsTerms.toggle() }) {
                Image(systemName: viewModel.acceptsTerms ? "checkmark.square.fill" : "square")
                    .font(.title2)
                    .foregroundColor(viewModel.acceptsTerms ? .appPurple : .appTextTertiary)
            }
            
            (
                Text("I agree to the ")
                +
                Text("Terms of Service").foregroundColor(.appPurple)
                +
                Text(" and ")
                +
                Text("Privacy Policy").foregroundColor(.appPurple)
            )
            .font(.footnote)
            .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
    
    private func handleSignUp() {
        Task {
            let success = await viewModel.signUp()
            if success {
                // TODO: Dismiss auth flow and show main app content
                print("Sign up successful")
            }
        }
    }
}

// MARK: - Previews
#Preview {
    NavigationStack {
        SignUpView()
    }
}
