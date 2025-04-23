import Foundation
import SwiftUI // For potential future use with Codable dictionary types

// Using Decodable for now, can add Encodable if needed for saving/API calls
struct Recipe: Identifiable, Decodable, Hashable {
    let id: UUID
    var userId: UUID? // Optional if recipe isn't tied to a user initially
    var imageUrl: String?
    var name: String
    var ingredients: [Ingredient]? // Define Ingredient struct below or elsewhere
    var instructions: [InstructionStep]? // Define InstructionStep struct below or elsewhere
    var nutrition: NutritionInfo? // Define NutritionInfo struct below or elsewhere
    var tips: [String]? // Simple array of strings for tips
    var tags: [String]? // Simple array of strings for tags
    var prepTime: Int? // In minutes
    var cookTime: Int? // In minutes
    var servings: Int?
    var difficultyLevel: String? // e.g., "Easy", "Medium", "Hard"
    var createdAt: Date?
    var updatedAt: Date?

    // Define nested or separate structs for complex JSON types if needed
    struct Ingredient: Identifiable, Decodable, Hashable {
        let id = UUID() // For list identification if needed
        var name: String
        var quantity: String // e.g., "1/2 cup", "2", "1 tbsp"
    }

    struct InstructionStep: Identifiable, Decodable, Hashable {
        let id = UUID() // For list identification if needed
        var stepNumber: Int
        var description: String
    }

    struct NutritionInfo: Decodable, Hashable {
        var calories: String?
        var protein: String?
        var fat: String?
        var carbohydrates: String?
        // Add other nutrition details as needed
    }

    // CodingKeys for potentially different JSON keys vs Swift property names
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case imageUrl = "image_url"
        case name
        case ingredients
        case instructions
        case nutrition
        case tips
        case tags
        case prepTime = "prep_time"
        case cookTime = "cook_time"
        case servings
        case difficultyLevel = "difficulty_level"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    // Provide a sample for previews and testing
    static var sample: Recipe {
        Recipe(
            id: UUID(),
            userId: UUID(),
            imageUrl: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/spaghetti-puttanesca_1-1ce4e81.jpg", // Placeholder image
            name: "Sample Spaghetti Recipe",
            ingredients: [
                Ingredient(name: "Spaghetti", quantity: "200g"),
                Ingredient(name: "Canned tomatoes", quantity: "1 can"),
                Ingredient(name: "Garlic", quantity: "2 cloves"),
                Ingredient(name: "Olive oil", quantity: "2 tbsp"),
                Ingredient(name: "Olives", quantity: "1/2 cup"),
                Ingredient(name: "Capers", quantity: "2 tbsp")
            ],
            instructions: [
                InstructionStep(stepNumber: 1, description: "Cook spaghetti according to package directions."),
                InstructionStep(stepNumber: 2, description: "While spaghetti cooks, heat olive oil in a pan."),
                InstructionStep(stepNumber: 3, description: "Sauté garlic until fragrant."),
                InstructionStep(stepNumber: 4, description: "Add tomatoes, olives, and capers. Simmer for 10 minutes."),
                InstructionStep(stepNumber: 5, description: "Drain spaghetti and toss with sauce.")
            ],
            nutrition: NutritionInfo(calories: "550 kcal", protein: "15g", fat: "20g", carbohydrates: "75g"),
            tips: ["Add red pepper flakes for heat.", "Use fresh basil if available."],
            tags: ["Pasta", "Italian", "Quick", "Vegetarian"],
            prepTime: 10,
            cookTime: 20,
            servings: 2,
            difficultyLevel: "Easy",
            createdAt: Date(),
            updatedAt: Date()
        )
    }

     // Another sample
     static var sample2: Recipe {
        Recipe(
            id: UUID(),
            userId: UUID(),
            imageUrl: "https://www.allrecipes.com/thmb/SoBuPU73wbeV6gjVpGcW07N_kQc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/8805-CrispyFriedChicken-mfs-3x2-072-d5a1716591704436ba74e514314ed601.jpg", // Placeholder
            name: "Crispy Fried Chicken",
            ingredients: [
                Ingredient(name: "Chicken pieces", quantity: "8"),
                Ingredient(name: "All-purpose flour", quantity: "2 cups"),
                Ingredient(name: "Salt", quantity: "2 tbsp"),
                Ingredient(name: "Black pepper", quantity: "1 tbsp"),
                Ingredient(name: "Paprika", quantity: "1 tbsp"),
                Ingredient(name: "Garlic powder", quantity: "1 tsp"),
                Ingredient(name: "Eggs", quantity: "2"),
                Ingredient(name: "Milk", quantity: "1/2 cup"),
                Ingredient(name: "Vegetable oil", quantity: "3 cups")
            ],
            instructions: [
                InstructionStep(stepNumber: 1, description: "In a bowl, mix flour, salt, pepper, paprika, and garlic powder."),
                InstructionStep(stepNumber: 2, description: "In another bowl, whisk eggs and milk."),
                InstructionStep(stepNumber: 3, description: "Dip each chicken piece in the egg mixture, then dredge in the flour mixture, ensuring fully coated."),
                InstructionStep(stepNumber: 4, description: "Heat vegetable oil in a large skillet over medium-high heat."),
                InstructionStep(stepNumber: 5, description: "Carefully place chicken in hot oil. Fry for about 6-8 minutes on each side, until golden brown and cooked through."),
                InstructionStep(stepNumber: 6, description: "Remove chicken and place on a wire rack to drain excess oil.")
            ],
            nutrition: NutritionInfo(calories: "700 kcal", protein: "45g", fat: "40g", carbohydrates: "35g"),
            tips: ["For extra crispy chicken, double dredge (dip in egg, then flour, then egg, then flour again).", "Ensure oil temperature is around 350°F (175°C)."],
            tags: ["Chicken", "Fried", "Comfort Food", "American"],
            prepTime: 20,
            cookTime: 25,
            servings: 4,
            difficultyLevel: "Medium",
            createdAt: Date(),
            updatedAt: Date()
        )
    }

    static var sample3: Recipe {
         Recipe(
             id: UUID(),
             userId: UUID(),
             imageUrl: "https://static01.nyt.com/images/2023/08/31/multimedia/31SALMONRICE-fzkw/31SALMONRICE-fzkw-square640.jpg",
             name: "Spicy Salmon Hand Rolls",
             ingredients: [
                 Ingredient(name: "square toasted nori sheets", quantity: "5"),
                 Ingredient(name: "canned spicy salmon or tuna", quantity: "13.2-4-oz."),
                 Ingredient(name: "cup mayonnaise", quantity: "¼"),
                 Ingredient(name: "Cooked sushi rice", quantity: "for filling"),
                 Ingredient(name: "avocado, thinly sliced", quantity: "1"),
                 Ingredient(name: "medium cucumber, cut into matchsticks", quantity: "½"),
                 Ingredient(name: "Gochugaru (Korean red pepper powder) or other mild red pepper flakes", quantity: "for serving")
             ],
             instructions: [
                 InstructionStep(stepNumber: 1, description: "Cut 5 square toasted nori sheets in half to make 10 rectangles. Place one 3.2-4-oz. can spicy salmon or tuna in a medium bowl, reserving any oil in can. Stir in ¼ cup mayonnaise and 1 Tbsp. reserved oil with a fork, breaking up and coating salmon."),
                 InstructionStep(stepNumber: 2, description: "Working one at a time, set nori sheets, shiny side down, on a surface with a long side closer to you. Moisten fingertips with water and spread about ¼ cup sushi rice over left half of nori, leaving a ½\" border along top, bottom, and left edges. Arrange a few slices of avocado and a few matchsticks of cucumber horizontally over rice. Top with about 1½ Tbsp. spicy salmon mixture."),
                 InstructionStep(stepNumber: 3, description: "Starting at bottom left corner, fold nori diagonally up and over filling so bottom edge lines up with right edge of nori. Continue to roll nori tightly into a cone shape. Moisten top right corner with a little water and press to seal. Serve hand rolls immediately with gochugaru for sprinkling over.")
             ],
             nutrition: NutritionInfo(calories: "300 kcal", protein: "20g", fat: "15g", carbohydrates: "25g"),
             tips: ["Make sure sushi rice is seasoned correctly.", "Don't overfill the rolls."],
             tags: ["Japanese", "Seafood", "Spicy", "Quick"],
             prepTime: 25,
             cookTime: 0, // No cooking needed if using canned salmon and pre-cooked rice
             servings: 10, // Makes 10 hand rolls
             difficultyLevel: "Easy",
             createdAt: Date(),
             updatedAt: Date()
         )
     }

     static var sample4: Recipe {
         Recipe(
             id: UUID(),
             userId: UUID(),
             imageUrl: "https://assets.bonappetit.com/photos/61099e678a57511b0c7c339a/1:1/w_1920,c_limit/HF-Everything-Green-Herb-Salad.jpg",
             name: "Everything Green Herb Salad",
             ingredients: [
                Ingredient(name: "mixed tender greens (such as Little Gem, butter lettuce, or baby romaine)", quantity: "8 cups"),
                Ingredient(name: "mixed tender herbs (such as parsley, cilantro, dill, mint, tarragon, chives)", quantity: "2 cups"),
                Ingredient(name: "avocado, thinly sliced", quantity: "1"),
                Ingredient(name: "shallot, very thinly sliced", quantity: "1 small"),
                Ingredient(name: "roasted unsalted sunflower seeds", quantity: "¼ cup"),
                Ingredient(name: "Extra-virgin olive oil", quantity: "3 Tbsp."),
                Ingredient(name: "Fresh lemon juice", quantity: "1 Tbsp."),
                Ingredient(name: "Kosher salt", quantity: "To taste"),
                Ingredient(name: "Freshly ground black pepper", quantity: "To taste"),
             ],
             instructions: [
                InstructionStep(stepNumber: 1, description: "Combine greens, herbs, avocado, shallot, and sunflower seeds in a large bowl."),
                InstructionStep(stepNumber: 2, description: "Whisk oil and lemon juice in a small bowl; season vinaigrette with salt and pepper."),
                InstructionStep(stepNumber: 3, description: "Drizzle vinaigrette over salad and toss gently to coat. Season salad with more salt and pepper if needed.")
             ],
             nutrition: NutritionInfo(calories: "250 kcal", protein: "5g", fat: "22g", carbohydrates: "10g"),
             tips: ["Use the freshest herbs you can find.", "Add other seeds like pumpkin or sesame if desired."],
             tags: ["Salad", "Green", "Healthy", "Vegetarian", "Gluten-Free", "Quick"],
             prepTime: 15,
             cookTime: 0,
             servings: 4,
             difficultyLevel: "Easy",
             createdAt: Date(),
             updatedAt: Date()
         )
     }

      static var sample5: Recipe {
         Recipe(
             id: UUID(),
             userId: UUID(),
             imageUrl: "https://images.squarespace-cdn.com/content/v1/5cf6a3463c63f1000111c721/1619278241706-QGWN7S9ZEDK8Y322JFRS/Scallops+in+Brown+Butter+Caper+Sauce+-+Real+Simple+Gourmet",
             name: "Scallops in Brown Butter & Caper Sauce",
             ingredients: [
                 Ingredient(name: "large sea scallops, patted dry", quantity: "1 lb"),
                 Ingredient(name: "Kosher salt", quantity: "½ tsp"),
                 Ingredient(name: "Freshly ground black pepper", quantity: "¼ tsp"),
                 Ingredient(name: "Unsalted butter", quantity: "4 Tbsp"),
                 Ingredient(name: "Capers, drained", quantity: "2 Tbsp"),
                 Ingredient(name: "Fresh lemon juice", quantity: "1 Tbsp"),
                 Ingredient(name: "Fresh parsley, chopped", quantity: "2 Tbsp"),
                 Ingredient(name: "Cooked pasta or crusty bread", quantity: "For serving")
             ],
             instructions: [
                 InstructionStep(stepNumber: 1, description: "Season scallops with salt and pepper."),
                 InstructionStep(stepNumber: 2, description: "Melt 2 tablespoons butter in a large skillet over medium-high heat. Add scallops in a single layer (work in batches if needed) and cook until golden brown and cooked through, about 1-2 minutes per side."),
                 InstructionStep(stepNumber: 3, description: "Transfer scallops to a plate."),
                 InstructionStep(stepNumber: 4, description: "Reduce heat to medium. Add remaining 2 tablespoons butter to the skillet. Cook, swirling occasionally, until butter melts, foams, then turns golden brown and smells nutty, about 2-3 minutes."),
                 InstructionStep(stepNumber: 5, description: "Stir in capers and lemon juice. Cook for 30 seconds."),
                 InstructionStep(stepNumber: 6, description: "Return scallops to the skillet and toss to coat. Stir in parsley."),
                 InstructionStep(stepNumber: 7, description: "Serve immediately over pasta or with bread.")
             ],
             nutrition: NutritionInfo(calories: "400 kcal", protein: "35g", fat: "25g", carbohydrates: "5g"),
             tips: ["Ensure scallops are very dry before searing for a good crust.", "Don't overcrowd the pan when searing.", "Watch the butter carefully to avoid burning."],
             tags: ["Seafood", "Scallops", "Quick", "Elegant"],
             prepTime: 10,
             cookTime: 10,
             servings: 2,
             difficultyLevel: "Medium",
             createdAt: Date(),
             updatedAt: Date()
         )
     }
} 