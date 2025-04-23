import SwiftUI

struct IntroView: View {
    // State to control navigation
    @State private var navigateToAuth = false

    var body: some View {
        // Use NavigationStack for modern navigation
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()

                // App Title/Logo Area (Placeholder)
                VStack {
                    Image(systemName: "fork.knife.circle.fill") // Placeholder icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.accentColor)

                    Text("WiseBites")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 10)

                    Text("Your AI Recipe Companion")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                Spacer()

                // Get Started Button
                Button("Get Started") {
                    navigateToAuth = true
                }
                .buttonStyle(.borderedProminent) // Native prominent style
                .controlSize(.large)
                .padding(.horizontal, 40)
                .padding(.bottom, 50) // Ensure button is off the bottom edge

                // Navigation Destination
                .navigationDestination(isPresented: $navigateToAuth) {
                     AuthView() // Navigate to AuthView when button tapped
                 }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .systemGroupedBackground)) // Use a subtle background
            .navigationTitle("Welcome") // Set title, but hide it on this root view
            .navigationBarHidden(true)
        }
        .tint(Color.green) // Set the accent color for the app
    }
}

#Preview {
    IntroView()
} 