import SwiftUI

struct ComposeView: View {

    // State for form fields
    @State private var recipeName: String = ""
    @State private var ingredients: [Recipe.Ingredient] = [Recipe.Ingredient(name: "", quantity: "")] // Start with one empty ingredient
    @State private var instructions: [Recipe.InstructionStep] = [Recipe.InstructionStep(stepNumber: 1, description: "")] // Start with one empty step
    @State private var prepTime: String = ""
    @State private var cookTime: String = ""
    @State private var servings: String = ""
    @State private var selectedDifficulty: String = "Easy" // Default difficulty
    @State private var tagsString: String = "" // Comma-separated tags

    let difficultyLevels = ["Easy", "Medium", "Hard"]

    // Environment for dismissing the view
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView { // Embed in NavigationView for title and toolbar
            Form {
                Section("Recipe Details") {
                    TextField("Recipe Name", text: $recipeName)

                    HStack {
                        TextField("Prep Time (min)", text: $prepTime)
                            .keyboardType(.numberPad)
                        TextField("Cook Time (min)", text: $cookTime)
                            .keyboardType(.numberPad)
                    }

                    TextField("Servings", text: $servings)
                        .keyboardType(.numberPad)

                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(difficultyLevels, id: \.self) { level in
                            Text(level).tag(level)
                        }
                    }

                    TextField("Tags (comma-separated)", text: $tagsString)
                        .autocapitalization(.none)
                }

                Section("Ingredients") {
                    ForEach($ingredients) { $ingredient in
                        IngredientInputRow(ingredient: $ingredient)
                    }
                    Button("Add Ingredient") {
                        withAnimation {
                           ingredients.append(Recipe.Ingredient(name: "", quantity: ""))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }

                Section("Instructions") {
                     ForEach($instructions) { $instruction in
                         InstructionInputRow(instruction: $instruction, index: instructions.firstIndex(where: { $0.id == instruction.id }) ?? 0)
                     }
                     Button("Add Step") {
                        withAnimation {
                            let nextStepNumber = (instructions.last?.stepNumber ?? 0) + 1
                            instructions.append(Recipe.InstructionStep(stepNumber: nextStepNumber, description: ""))
                        }
                     }
                     .frame(maxWidth: .infinity, alignment: .center)
                 }

                // TODO: Add sections for Image Upload, Nutrition, Tips

            }
            .navigationTitle("Compose Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveRecipe()
                    }
                    .disabled(recipeName.isEmpty) // Basic validation
                }
            }
        }
    }

    // MARK: - Helper Input Rows

    struct IngredientInputRow: View {
        @Binding var ingredient: Recipe.Ingredient

        var body: some View {
            HStack {
                TextField("Quantity", text: $ingredient.quantity)
                    .frame(width: 100) // Adjust width as needed
                TextField("Ingredient Name", text: $ingredient.name)
                // TODO: Add delete button for the row
            }
        }
    }

    struct InstructionInputRow: View {
        @Binding var instruction: Recipe.InstructionStep
        let index: Int

        var body: some View {
            HStack(alignment: .top) {
                Text("\(index + 1).")
                    .padding(.top, 8) // Align with text editor top
                TextEditor(text: $instruction.description)
                    .frame(height: 80) // Adjust height as needed
                 // TODO: Add delete button for the row
            }
        }
    }

    // MARK: - Actions
    func saveRecipe() {
        print("Saving Recipe...")

        // Convert form state to Recipe object (basic example)
        let newRecipe = Recipe(
            id: UUID(),
            userId: nil, // Assign actual user ID
            imageUrl: nil, // Handle image upload separately
            name: recipeName,
            ingredients: ingredients.filter { !$0.name.isEmpty }, // Filter out empty ingredients
            instructions: instructions.filter { !$0.description.isEmpty }, // Filter out empty steps
            nutrition: nil,
            tips: nil,
            tags: tagsString.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty },
            prepTime: Int(prepTime),
            cookTime: Int(cookTime),
            servings: Int(servings),
            difficultyLevel: selectedDifficulty,
            createdAt: Date(),
            updatedAt: Date()
        )

        print("Recipe to save: \(newRecipe)")
        // TODO: Implement actual saving logic (e.g., save to database/API)

        dismiss() // Dismiss the view after saving
    }
}

#Preview {
    ComposeView()
        .tint(Color.green)
} 