import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    // State for the segmented control
    @State private var selectedSegment: Segment = .ingredients

    enum Segment: String, CaseIterable {
        case ingredients = "Ingredients"
        case directions = "Directions"
    }

    // Environment for presentation mode (needed for custom back button maybe)
    // @Environment(\.presentationMode) var presentationMode

    // State for edit/delete actions (placeholder)
    @State private var showingActionSheet = false
    @State private var navigateToEdit = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // --- Header Image ---
                GeometryReader { geometry in
                     AsyncImage(url: URL(string: recipe.imageUrl ?? "")) { image in
                         image.resizable()
                             .aspectRatio(contentMode: .fill)
                             .frame(width: geometry.size.width, height: 300)
                             .clipped()
                     } placeholder: {
                         Rectangle()
                             .fill(Color.gray.opacity(0.3))
                             .frame(width: geometry.size.width, height: 300)
                             .overlay { ProgressView() }
                     }
                 }
                .frame(height: 300)

                // --- Recipe Info Header ---
                VStack(alignment: .leading, spacing: 10) {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    // Placeholder for source/author
                    HStack {
                        Image(systemName: "person.circle") // Placeholder
                        Text("Source Placeholder") // e.g., Bon Appétit
                            .font(.subheadline)
                    }
                    .foregroundColor(.secondary)

                    // Action Buttons (Save, Share, etc. - Mock)
                    HStack(spacing: 20) {
                        actionButton(icon: "bookmark", label: "Save")
                        actionButton(icon: "square.and.arrow.up", label: "Share")
                        // Add more actions as needed
                        Spacer()
                    }
                    .padding(.vertical)

                    // Quick Info (Prep Time, Cook Time, Servings)
                    HStack {
                        infoItem(icon: "clock", label: "Prep", value: "\(recipe.prepTime ?? 0)m")
                        infoItem(icon: "flame", label: "Cook", value: "\(recipe.cookTime ?? 0)m")
                        infoItem(icon: "person.2", label: "Serves", value: "\(recipe.servings ?? 0)")
                        infoItem(icon: "chart.bar", label: "Difficulty", value: recipe.difficultyLevel ?? "N/A")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom)

                }
                .padding()
                .background(.thinMaterial) // Subtle background separation

                // --- Ingredients / Directions Segmented Control ---
                Picker("Details", selection: $selectedSegment) {
                    ForEach(Segment.allCases, id: \.self) { segment in
                        Text(segment.rawValue).tag(segment)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                // --- Content based on Segment ---
                if selectedSegment == .ingredients {
                    IngredientListView(ingredients: recipe.ingredients ?? [])
                } else {
                    InstructionListView(instructions: recipe.instructions ?? [])
                }

                // --- Tips Section (Optional) ---
                if let tips = recipe.tips, !tips.isEmpty {
                    SectionHeader(title: "Tips")
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(tips, id: \.self) { tip in
                            Text("• \(tip)")
                        }
                    }
                    .padding()
                }

                // --- Nutrition Section (Optional) ---
                 if let nutrition = recipe.nutrition {
                    SectionHeader(title: "Nutrition (Approximate)")
                    NutritionView(nutrition: nutrition)
                        .padding()
                 }

            } // End of main VStack
        } // End of ScrollView
        .navigationTitle(recipe.name) // Set title but likely hidden by large display mode
        .navigationBarTitleDisplayMode(.inline) // Keep it inline to show back button
        .toolbar {
            // Settings/Edit Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingActionSheet = true
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        // Action Sheet for Edit/Delete
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Recipe Options"), buttons: [
                .default(Text("Edit Recipe")) { navigateToEdit = true },
                .destructive(Text("Delete Recipe")) { /* TODO: Implement Delete */ print("Delete tapped") },
                .cancel()
            ])
        }
        // Navigation to Edit View (uses ComposeView for now)
         .navigationDestination(isPresented: $navigateToEdit) {
             // Ideally, pass the existing recipe to ComposeView for editing
             ComposeView() // Placeholder: just navigates to a new compose screen
         }
        .ignoresSafeArea(.container, edges: .top) // Allow image to go under status bar
    }

    // MARK: - Helper Views

    func actionButton(icon: String, label: String) -> some View {
        Button {
            print("\(label) tapped")
            // TODO: Implement action
        } label: {
            VStack {
                Image(systemName: icon)
                    .font(.title3)
                Text(label)
                    .font(.caption)
            }
            .frame(width: 60)
            .padding(.vertical, 5)
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }

    func infoItem(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text("\(label): \(value)")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(Capsule())
    }

    struct SectionHeader: View {
        let title: String
        var body: some View {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top)
        }
    }

    struct IngredientListView: View {
        let ingredients: [Recipe.Ingredient]
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(ingredients) { ingredient in
                    HStack(alignment: .top) {
                        // Use a bullet point or checkbox placeholder
                        Image(systemName: "circle") // Placeholder
                            .font(.caption)
                            .foregroundColor(.accentColor)
                            .padding(.top, 3)
                        VStack(alignment: .leading) {
                            Text(ingredient.name).fontWeight(.medium)
                            Text(ingredient.quantity).font(.subheadline).foregroundColor(.secondary)
                        }
                        Spacer() // Push content left
                    }
                }
            }
            .padding()
        }
    }

    struct InstructionListView: View {
        let instructions: [Recipe.InstructionStep]
        var body: some View {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(instructions) { instruction in
                    HStack(alignment: .top, spacing: 10) {
                        Text("\(instruction.stepNumber)")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                            .frame(width: 25, alignment: .trailing)
                        Text(instruction.description)
                            .fixedSize(horizontal: false, vertical: true) // Allow text wrap
                    }
                }
            }
            .padding()
        }
    }

    struct NutritionView: View {
        let nutrition: Recipe.NutritionInfo
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                if let calories = nutrition.calories { Text("Calories: \(calories)") }
                if let protein = nutrition.protein { Text("Protein: \(protein)") }
                if let fat = nutrition.fat { Text("Fat: \(fat)") }
                if let carbs = nutrition.carbohydrates { Text("Carbohydrates: \(carbs)") }
                // Add more fields as needed
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: Recipe.sample3) // Use a sample recipe
    }
    .tint(Color.green)
} 