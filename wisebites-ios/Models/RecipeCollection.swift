import Foundation

// Represents the relationship between a Recipe and a Collection
struct RecipeCollection: Identifiable, Codable {
    let id: UUID
    var collectionId: UUID
    var recipeId: UUID
    var createdAt: Date?

    // CodingKeys for matching database column names
    enum CodingKeys: String, CodingKey {
        case id
        case collectionId = "collection_id"
        case recipeId = "recipe_id"
        case createdAt = "created_at"
    }

    // Sample data (assuming existence of Recipe.sample and Collection.sample1 etc.)
    // Note: These will cause errors if Recipe/Collection files aren't compiled first
    // We might need a dedicated MockDataService to handle dependencies
    // static var sample1 = RecipeCollection(id: UUID(), collectionId: Collection.sample1.id, recipeId: Recipe.sample.id, createdAt: Date())
    // static var sample2 = RecipeCollection(id: UUID(), collectionId: Collection.sample1.id, recipeId: Recipe.sample2.id, createdAt: Date())
} 