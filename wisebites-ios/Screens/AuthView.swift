import SwiftUI
import AuthenticationServices // Needed for Sign in with Apple button

struct AuthView: View {
    // State to control navigation to Subscription screen
    @State private var navigateToSubscription = false
    // Mock state to simulate successful login
    @State private var isLoggedIn = false // In a real app, this would come from an Auth Service/ViewModel

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Sign In or Sign Up")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 30)

            // --- Login Buttons --- 

            // Phone Number (OTP) Button
            Button {
                // Mock action: navigate to subscription
                navigateToSubscription = true
            } label: {
                HStack {
                    Image(systemName: "phone.fill")
                    Text("Continue with Phone Number")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered) // Use bordered style for secondary actions
            .controlSize(.large)

            // Sign in With Apple Button
            SignInWithAppleButton(
                .continue, // Use .signIn or .signUp based on context if needed
                onRequest: { request in
                    // Configure request parameters (e.g., scopes)
                    // request.requestedScopes = [.fullName, .email]
                    print("Apple Sign In Request")
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authorization):
                        // Handle successful authorization (e.g., get credentials)
                        print("Apple Sign In Success: \(authorization)")
                        // Mock action: navigate to subscription
                        navigateToSubscription = true
                    case .failure(let error):
                        // Handle error
                        print("Apple Sign In Error: \(error.localizedDescription)")
                        // TODO: Show error alert to user
                    }
                }
            )
            .signInWithAppleButtonStyle(.black) // Or .white, .whiteOutline
            .frame(height: 50) // Standard height for social login buttons
            .controlSize(.large)

            // Google Sign In Button (Placeholder)
            Button {
                // Mock action: navigate to subscription
                print("Google Sign In Tapped (Placeholder)")
                navigateToSubscription = true
            } label: {
                HStack {
                    // Use a simple placeholder or find a Google icon asset
                    Image(systemName: "g.circle.fill") // Placeholder
                    Text("Continue with Google")
                }
                 .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered) // Consistent style with phone
            .controlSize(.large)
            .tint(.gray) // Neutral tint for placeholder

            Spacer()
            Spacer() // Add more space at the bottom
        }
        .padding(.horizontal, 40)
        .navigationTitle("Authentication")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea())
        // Navigation Destination to Subscription View
        .navigationDestination(isPresented: $navigateToSubscription) {
            SubscriptionView() // Navigate here after any auth action (for now)
        }
        // TODO: Add logic to navigate directly to HomeView if user is already logged in
        // and has a subscription status.
    }
}

#Preview {
    // Embed in NavigationStack for preview context
    NavigationStack {
        AuthView()
    }
    .tint(Color.green)
} 