import SwiftUI

struct SubscriptionView: View {
    // State to control navigation to Home screen
    @State private var navigateToHome = false

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Choose Your Plan")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            Text("Unlock features tailored to your cooking style.")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.bottom)

            // Mock Subscription Options
            SubscriptionOptionCard(planName: "Free", price: "$0/month", description: "Basic recipe access and features.", isSelected: false) {
                navigateToHome = true // Navigate on selection
            }

            SubscriptionOptionCard(planName: "Standard", price: "$4.99/month", description: "Unlimited recipes, collections, and standard AI features.", isSelected: false) {
                 navigateToHome = true // Navigate on selection
             }

            SubscriptionOptionCard(planName: "Pro", price: "$9.99/month", description: "All Standard features plus advanced AI insights and meal planning.", isSelected: false) {
                 navigateToHome = true // Navigate on selection
             }

            Spacer() // Push content to the top
        }
        .padding()
        .navigationTitle("Subscription")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea())
        // Navigation Destination to Home View
        .navigationDestination(isPresented: $navigateToHome) {
            // We need a way to dismiss the auth/subscription flow and show the main app interface (e.g., HomeView within a TabView)
            // For now, just navigating to HomeView directly.
            // This might need adjustment later depending on the root view structure.
            HomeView()
                .navigationBarBackButtonHidden(true) // Hide back button once in main app flow
        }
        // TODO: Implement actual selection state and logic for subscription choice.
    }
}

// Reusable Card View for Subscription Options
struct SubscriptionOptionCard: View {
    let planName: String
    let price: String
    let description: String
    let isSelected: Bool // Placeholder for selection state
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(planName)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(price)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true) // Allow text wrapping
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 2) // Highlight if selected (mock)
            )
        }
        .buttonStyle(.plain) // Use plain style to make the whole card tappable
    }
}

#Preview {
    NavigationStack {
        SubscriptionView()
    }
    .tint(Color.green)
} 