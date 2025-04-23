import SwiftUI

struct CollectionView: View {
    let collection: Collection
    private let dataService = MockDataService()

    // State for recipes in this collection
    @State private var recipes: [Recipe] = []

    // State for navigation and actions
    @State private var navigateToRecipeDetail: Recipe? = nil
    @State private var showingActionSheet = false
    @State private var showingEditSheet = false // For editing collection name
    @State private var editedCollectionName: String = ""

    // Grid layout configuration
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    private let cardHeight: CGFloat = 240 // Match HomeView card height

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(recipes) { recipe in
                    RecipeCardView(recipe: recipe) // Reuse card from HomeView
                        .frame(height: cardHeight)
                        .onTapGesture {
                            navigateToRecipeDetail = recipe
                        }
                }
            }
            .padding()
        }
        .navigationTitle(collection.name)
        .navigationBarTitleDisplayMode(.large) // Use large title like Saved Recipes image
        .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingActionSheet = true
                    editedCollectionName = collection.name // Pre-fill edit sheet
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .onAppear {
            // Load recipes for this collection
            recipes = dataService.getRecipes(for: collection)
        }
        // Navigation to Recipe Detail
        .navigationDestination(item: $navigateToRecipeDetail) { recipe in
            RecipeDetailView(recipe: recipe)
        }
        // Action Sheet for Edit/Delete Collection
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Collection Options"), buttons: [
                .default(Text("Edit Collection")) { showingEditSheet = true },
                .destructive(Text("Delete Collection")) { /* TODO: Implement Delete */ print("Delete Collection tapped") },
                .cancel()
            ])
        }
        // Sheet for Editing Collection Name
        .sheet(isPresented: $showingEditSheet) {
            NavigationView {
                VStack(spacing: 20) {
                    Text("Edit Collection Name").font(.headline)
                    TextField("Collection Name", text: $editedCollectionName)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    Spacer()
                    Button("Save Changes") {
                        // TODO: Implement actual save logic for collection name
                        print("Saving new collection name: \(editedCollectionName)")
                        // Update local title if needed, though view should ideally reload
                        // collection.name = editedCollectionName // This won't work as let constant
                        showingEditSheet = false
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(editedCollectionName.isEmpty)
                }
                .padding()
                .navigationTitle("Edit Collection")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") { showingEditSheet = false }
                    }
                }
            }
        }

    }
}

#Preview {
    NavigationStack {
        // Use a sample collection for the preview
        CollectionView(collection: Collection.sample1)
    }
    .tint(Color.green)
} 