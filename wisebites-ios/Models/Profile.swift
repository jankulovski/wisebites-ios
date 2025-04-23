import Foundation

// Using Codable for potential future saving/API interaction
struct Profile: Identifiable, Codable {
    let id: UUID // Matches user_id in other tables
    var email: String?
    var fullName: String?
    var avatarUrl: String?
    var createdAt: Date?
    var updatedAt: Date?

    // CodingKeys for matching database/JSON keys
    enum CodingKeys: String, CodingKey {
        case id // Assuming the profile ID *is* the user ID
        case email
        case fullName = "full_name"
        case avatarUrl = "avatar_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    // Sample data for previews and testing
    static var sample = Profile(
        id: UUID(), // Use a consistent UUID if mocking relationships
        email: "user@example.com",
        fullName: "Jane Doe",
        avatarUrl: nil, // No avatar initially
        createdAt: Date(),
        updatedAt: Date()
    )
} 