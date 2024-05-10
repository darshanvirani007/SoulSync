import Foundation
import FirebaseFirestore

struct Post: Identifiable {
    var id: String
    var content: String
    var createdAt: Date
    var mediaURL: String?
    var likesCount: Int
    var commentsCount: Int
    var user: User

    init(id: String, data: [String: Any]) {
        self.id = id
        self.content = data["content"] as? String ?? ""
        if let timestamp = data["createdAt"] as? Timestamp {
            self.createdAt = timestamp.dateValue()
        } else {
            self.createdAt = Date()
        }
        self.mediaURL = data["mediaURL"] as? String
        self.likesCount = data["likesCount"] as? Int ?? 0
        self.commentsCount = data["commentsCount"] as? Int ?? 0

        // Initialize the user object
        if let userData = data["user"] as? [String: Any] {
            self.user = User(id: data["authorId"] as? String ?? "", data: userData)
        } else {
            self.user = User(id: "", data: [:])
        }
    }

    var dictionary: [String: Any] {
        return [
            "content": content,
            "createdAt": FieldValue.serverTimestamp(),
            "mediaURL": mediaURL ?? "",
            "likesCount": likesCount,
            "commentsCount": commentsCount,
            "user": user.dictionary
        ]
    }
}

struct Comment: Identifiable {
    var id: String
    var content: String
    var authorId: String
    var createdAt: Date

    init(id: String, data: [String: Any]) {
        self.id = id
        self.content = data["content"] as? String ?? ""
        self.authorId = data["authorId"] as? String ?? ""
        if let timestamp = data["createdAt"] as? Timestamp {
            self.createdAt = timestamp.dateValue()
        } else {
            self.createdAt = Date()
        }
    }

    var dictionary: [String: Any] {
        return [
            "content": content,
            "authorId": authorId,
            "createdAt": FieldValue.serverTimestamp()
        ]
    }
}

struct User: Codable {
    var id: String
    var name: String
    var email: String
    var profilePictureURL: String?

    init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? "Unknown"
        self.email = data["email"] as? String ?? ""
        self.profilePictureURL = data["profilePictureURL"] as? String
    }

    var dictionary: [String: Any] {
        return [
            "id": id,
            "name": name,
            "email": email,
            "profilePictureURL": profilePictureURL ?? ""
        ]
    }
}
