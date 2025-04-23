import Foundation

// Simple service to provide mock data for UI development and previews.
// In a real app, this would be replaced by actual data fetching logic (API, CoreData, etc.)
class MockDataService {

    // MARK: - Shared Instance (Optional)
    // static let shared = MockDataService() // Use if needed across multiple views easily

    // MARK: - Mock Recipes
    func getLatestRecipes() -> [Recipe] {
        // Return a subset of the sample recipes
        return [Recipe.sample, Recipe.sample2, Recipe.sample3, Recipe.sample4, Recipe.sample5].shuffled() // Shuffle for variety
    }

    func getRecentlyViewedRecipes() -> [Recipe] {
        // Return a different subset for variety
        return [Recipe.sample5, Recipe.sample4, Recipe.sample, Recipe.sample3].shuffled()
    }

    func getSavedRecipes() -> [Recipe] {
        // Return another subset
        return [Recipe.sample, Recipe.sample3, Recipe.sample2, Recipe.sample4].shuffled()
    }

    func getAllRecipes() -> [Recipe] {
        // Return all available samples
        return [Recipe.sample, Recipe.sample2, Recipe.sample3, Recipe.sample4, Recipe.sample5]
    }

    func getRecipes(for collection: Collection) -> [Recipe] {
        // Mock logic: Return recipes based on collection name
        switch collection.name {
        case "Weeknight Dinners":
            return [Recipe.sample, Recipe.sample5].shuffled()
        case "Holiday Baking": // Add baking recipes if available
            return [Recipe.sample2] // Placeholder
        case "Vegetarian Favorites":
            return [Recipe.sample, Recipe.sample4].shuffled()
        default:
            return [Recipe.sample3, Recipe.sample4, Recipe.sample5].shuffled() // Default mix
        }
    }

    // MARK: - Mock Collections
    func getCollections() -> [Collection] {
        return [Collection.sample1, Collection.sample2, Collection.sample3]
    }

    // MARK: - Mock Filters (Tags)
    func getFilterTags() -> [String] {
        // Combine tags from sample recipes and add common ones
        let allTags = Set([
            "Dinner", "Easy", "Vegetarian", "Dessert", "< 30 Mins", "Breakfast",
            "Pasta", "Italian", "Quick", "Chicken", "Fried", "Comfort Food", "American",
            "Japanese", "Seafood", "Spicy", "Salad", "Green", "Healthy", "Gluten-Free",
            "Scallops", "Elegant"
        ])
        return Array(allTags).sorted() // Return sorted unique tags
    }
} 