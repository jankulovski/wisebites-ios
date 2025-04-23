import SwiftUI

struct ProfileView: View {

    // Mock profile data (replace with actual data source)
    @State private var profile = Profile.sample

    // State for navigation/presentation
    @State private var navigateToSubscription = false
    @State private var showingEditProfileSheet = false

    var body: some View {
        NavigationView { // Embed in NavigationView for title and toolbar items
            Form {
                // --- Profile Header ---
                Section {
                    HStack(spacing: 15) {
                        // Avatar Placeholder
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)

                        VStack(alignment: .leading) {
                            Text(profile.fullName ?? "Your Name")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text(profile.email ?? "your.email@example.com")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button {
                            showingEditProfileSheet = true
                        } label: {
                            Text("Edit")
                        }
                    }
                    .padding(.vertical, 5)
                }

                // --- Subscription Management ---
                Section("Subscription") {
                    // Mock display of current plan
                    HStack {
                        Text("Current Plan")
                        Spacer()
                        Text("Standard") // Placeholder
                            .foregroundColor(.secondary)
                    }

                    Button("Manage Subscription") {
                        navigateToSubscription = true
                    }
                    .foregroundColor(.accentColor)
                }

                // --- Settings (Mock Section) ---
                Section("Settings") {
                    settingRow(icon: "bell.fill", label: "Notifications")
                    settingRow(icon: "lock.fill", label: "Privacy & Security")
                    settingRow(icon: "questionmark.circle.fill", label: "Help & Support")
                }

                // --- Account Actions ---
                Section {
                    Button("Sign Out", role: .destructive) {
                        // TODO: Implement sign out logic
                        print("Sign Out tapped")
                        // TODO: Navigate back to Auth/Intro view
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            // Navigation to Subscription Management (reusing SubscriptionView)
            .navigationDestination(isPresented: $navigateToSubscription) {
                SubscriptionView() // Might want a dedicated management view later
            }
            // Sheet for Editing Profile
            .sheet(isPresented: $showingEditProfileSheet) {
                // Pass a binding to the profile for editing
                EditProfileSheet(profile: $profile)
            }
        }
    }

    // Helper for settings rows
    private func settingRow(icon: String, label: String) -> some View {
        Button {
            // TODO: Navigate to specific setting screen
            print("\(label) setting tapped")
        } label: {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .frame(width: 25, alignment: .center)
                Text(label)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray.opacity(0.5))
            }
            .foregroundColor(.primary) // Make text black
        }
    }
}

// MARK: - Edit Profile Sheet View

struct EditProfileSheet: View {
    @Binding var profile: Profile
    @Environment(\.dismiss) var dismiss

    // Local state for editing to avoid modifying binding directly until save
    @State private var editableFullName: String
    @State private var editableEmail: String

    init(profile: Binding<Profile>) {
        self._profile = profile
        // Initialize local state with bound profile data
        _editableFullName = State(initialValue: profile.wrappedValue.fullName ?? "")
        _editableEmail = State(initialValue: profile.wrappedValue.email ?? "")
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Personal Information") {
                    TextField("Full Name", text: $editableFullName)
                    TextField("Email Address", text: $editableEmail)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }

                Section("Profile Picture") {
                    // TODO: Add photo picker for avatar
                    HStack {
                        Text("Avatar")
                        Spacer()
                        Image(systemName: "person.crop.circle.badge.plus")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Apply changes to the binding
                        profile.fullName = editableFullName
                        profile.email = editableEmail
                        // TODO: Handle avatar saving
                        print("Profile changes saved (mock)")
                        dismiss()
                    }
                    .disabled(editableFullName.isEmpty) // Basic validation
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .tint(Color.green)
} 