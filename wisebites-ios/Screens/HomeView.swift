import SwiftUI

struct HomeView: View {
    // Mock data provider
    private let dataService = MockDataService()

    // State for search
    @State private var searchText = ""
    @State private var selectedFilter: String? = nil // Track selected filter tag

    // State for navigation
    @State private var navigateToRecipeDetail: Recipe? = nil
    @State private var navigateToCollection: Collection? = nil
    @State private var navigateToCaptureUpload = false
    @State private var navigateToCompose = false

    // State for FAB menu
    @State private var showFabOptions = false

    var body: some View {
        NavigationStack { // Each tab content might need its own stack
            ScrollView {
                VStack(alignment: .leading, spacing: 0) { // Use spacing 0 and add padding manually

                    // Filter Tags Horizontal Scroll
                    FilterTagScrollView(filters: dataService.getFilterTags(), selectedFilter: $selectedFilter)
                        .padding(.vertical)

                    // Recently Viewed Section (Based on Image 1)
                    RecipeSectionView(
                        title: "Recently Viewed",
                        recipes: dataService.getRecentlyViewedRecipes(),
                        onRecipeTap: { recipe in navigateToRecipeDetail = recipe },
                        onViewAllTap: { /* TODO: Navigate to full Recently Viewed list */ }
                    )

                    // Saved Recipes Section (Based on Image 2 - assuming this is a Collection)
                    // For now, let's represent this as a specific collection
                    if let savedCollection = dataService.getCollections().first(where: { $0.name == "Weeknight Dinners" }) { // Mock: Find a collection to represent 'Saved'
                         RecipeSectionView(
                             title: savedCollection.name,
                             recipes: dataService.getRecipes(for: savedCollection),
                             onRecipeTap: { recipe in navigateToRecipeDetail = recipe },
                             onViewAllTap: { navigateToCollection = savedCollection }
                         )
                    }

                     // Latest Recipes Section
                     RecipeSectionView(
                         title: "Latest Recipes",
                         recipes: dataService.getLatestRecipes(),
                         onRecipeTap: { recipe in navigateToRecipeDetail = recipe },
                         onViewAllTap: { /* TODO: Navigate to full Latest Recipes list */ }
                     )


                    // Dynamic Collections Sections
                    ForEach(dataService.getCollections().filter { $0.name != "Weeknight Dinners" }) { collection in // Exclude the one used for 'Saved'
                        RecipeSectionView(
                            title: collection.name,
                            recipes: dataService.getRecipes(for: collection),
                            onRecipeTap: { recipe in navigateToRecipeDetail = recipe },
                            onViewAllTap: { navigateToCollection = collection }
                        )
                    }

                    // Add Spacer at the bottom to ensure content scrolls above FAB
                    Spacer(minLength: 100)
                }
            }
            .navigationTitle("Recipe Catalog") // Title like Image 1
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Recipes")
            .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea())
            .overlay(alignment: .bottomTrailing) {
                fabMenu // Floating Action Button Menu
            }
            // Navigation Destinations
            .navigationDestination(item: $navigateToRecipeDetail) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .navigationDestination(item: $navigateToCollection) { collection in
                CollectionView(collection: collection)
            }
            .navigationDestination(isPresented: $navigateToCaptureUpload) {
                CaptureUploadView()
            }
             .navigationDestination(isPresented: $navigateToCompose) {
                 ComposeView()
             }
            // TODO: Add toolbar items (e.g., profile button if needed here)
        }
    }

    // MARK: - Floating Action Button Menu
    private var fabMenu: some View {
        VStack(spacing: 15) {
            if showFabOptions {
                fabOptionButton(icon: "camera.fill", label: "Capture") {
                    showFabOptions = false
                    navigateToCaptureUpload = true
                }
                fabOptionButton(icon: "photo.fill", label: "Upload") {
                    showFabOptions = false
                    // Navigate to CaptureUploadView, potentially with a flag for upload mode
                    navigateToCaptureUpload = true
                }
                fabOptionButton(icon: "square.and.pencil", label: "Compose") {
                    showFabOptions = false
                    navigateToCompose = true
                }
            }

            Button {
                withAnimation {
                    showFabOptions.toggle()
                }
            } label: {
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .rotationEffect(.degrees(showFabOptions ? 45 : 0))
            }
        }
        .padding()
    }

    // Helper for FAB option buttons
    private func fabOptionButton(icon: String, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .font(.headline)
                Spacer()
                Image(systemName: icon)
                    .font(.title2)
            }
            .padding()
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .foregroundColor(Color.accentColor)
            .clipShape(Capsule())
            .shadow(radius: 3)
        }
        .frame(maxWidth: 150) // Limit width of option buttons
        .transition(.move(edge: .trailing).combined(with: .opacity))
    }
}

// MARK: - Subviews for HomeView

// Horizontal Scroll View for Filter Tags
struct FilterTagScrollView: View {
    let filters: [String]
    @Binding var selectedFilter: String?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(filters, id: \.self) { filter in
                    Button {
                        withAnimation {
                             selectedFilter = (selectedFilter == filter) ? nil : filter
                        }
                        // TODO: Add filtering logic based on selection
                        print("Selected filter: \(selectedFilter ?? "None")")
                    } label: {
                        Text(filter)
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(selectedFilter == filter ? Color.accentColor : Color(uiColor: .secondarySystemGroupedBackground))
                            .foregroundColor(selectedFilter == filter ? .white : .primary)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// Reusable View for a Horizontal Recipe Section
struct RecipeSectionView: View {
    let title: String
    let recipes: [Recipe]
    let onRecipeTap: (Recipe) -> Void
    let onViewAllTap: () -> Void

    private let cardWidth: CGFloat = 180 // Width for the recipe cards
    private let cardHeight: CGFloat = 240 // Height for the recipe cards

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button("View All") {
                    onViewAllTap()
                }
                .font(.callout)
                .foregroundColor(.accentColor)
            }
            .padding(.horizontal)
            .padding(.top)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 15) {
                    ForEach(recipes) { recipe in
                        RecipeCardView(recipe: recipe)
                            .frame(width: cardWidth, height: cardHeight)
                            .onTapGesture {
                                onRecipeTap(recipe)
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .padding(.bottom) // Add spacing between sections
    }
}

// Simple Card View for a Recipe
struct RecipeCardView: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Image Area
            AsyncImage(url: URL(string: recipe.imageUrl ?? "")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.3) // Placeholder background
                // You could add a ProgressView here
            }
            .frame(height: 150) // Fixed height for image consistency
            .clipped()
            .overlay(alignment: .topTrailing) {
                 // Placeholder for source logo/edit icon like in images
                 Image(systemName: "book.closed.fill") // Example icon
                    .font(.caption)
                    .padding(5)
                    .background(.thinMaterial)
                    .clipShape(Circle())
                    .padding(6)
            }


            // Text Content
            VStack(alignment: .leading, spacing: 2) {
                Text(recipe.name)
                    .font(.headline)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true) // Allow wrapping

                 // Example: Display prep time
                if let prepTime = recipe.prepTime, let cookTime = recipe.cookTime {
                    Text("\(prepTime + cookTime) min")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                // Example: Display News+ tag (mock)
                 Text("#News+")
                    .font(.caption)
                    .foregroundColor(.red) // Example styling

            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)

            Spacer() // Push text content up if needed
        }
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}


#Preview {
    HomeView()
        .tint(Color.green)
} 