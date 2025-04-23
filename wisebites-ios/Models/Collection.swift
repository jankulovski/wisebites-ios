import Foundation

// Using Codable for potential future saving/API interaction
struct Collection: Identifiable, Codable, Hashable {
    let id: UUID
    var userId: UUID? // Optional if not always user-specific
    var name: String
    var createdAt: Date?
    var updatedAt: Date?

    // CodingKeys for matching database column names
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    // Sample data for previews and testing
    static var sample1 = Collection(id: UUID(), userId: UUID(), name: "Weeknight Dinners", createdAt: Date(), updatedAt: Date())
    static var sample2 = Collection(id: UUID(), userId: UUID(), name: "Holiday Baking", createdAt: Date(), updatedAt: Date())
    static var sample3 = Collection(id: UUID(), userId: UUID(), name: "Vegetarian Favorites", createdAt: Date(), updatedAt: Date())
} 