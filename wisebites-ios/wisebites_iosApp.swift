//
//  wisebites_iosApp.swift
//  wisebites-ios
//
//  Created by chris on 4/23/25.
//

import SwiftUI

@main
struct wisebites_iosApp: App {
    // StateObject to manage authentication status (mock for now)
    // @StateObject private var authManager = AuthManager() // Example for future use

    var body: some Scene {
        WindowGroup {
            // Start with the IntroView, which contains its own NavigationStack
            IntroView()
                // In a real app, you might have a root view that decides
                // whether to show Intro/Auth or the main TabView based on auth state.
                // For example:
                // if authManager.isLoggedIn {
                //     MainTabView() 
                // } else {
                //     IntroView()
                // }
                .tint(Color.green) // Apply the accent color globally if desired
        }
    }
}

// Placeholder for a potential MainTabView combining Home and Profile
// struct MainTabView: View {
//     var body: some View {
//         TabView {
//             HomeView()
//                 .tabItem {
//                     Label("Recipes", systemImage: "fork.knife")
//                 }
//             
//             ProfileView()
//                 .tabItem {
//                     Label("Profile", systemImage: "person.crop.circle")
//                 }
//             // Add other main tabs as needed
//         }
//     }
// }
