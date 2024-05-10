import Foundation
import FirebaseFirestore
import FirebaseStorage

class FirestoreManager {
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()
    private let storage = Storage.storage()

    private init() {}

    func createPost(content: String, user: User, media: Data?, completion: @escaping (Result<Void, Error>) -> Void) {
        let postRef = db.collection("posts").document()

        var postDictionary: [String: Any] = [
            "content": content,
            "createdAt": FieldValue.serverTimestamp(),
            "likesCount": 0,
            "commentsCount": 0,
            "mediaURL": "",
            "user": user.dictionary
        ]

        if let media = media {
            let mediaRef = storage.reference(withPath: "posts/\(postRef.documentID)/media.jpg")
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            print("Starting media upload to path: posts/\(postRef.documentID)/media.jpg")

            mediaRef.putData(media, metadata: metadata) { _, error in
                if let error = error {
                    print("Error uploading media: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }

                mediaRef.downloadURL { url, error in
                    if let error = error {
                        print("Error fetching download URL: \(error.localizedDescription)")
                        completion(.failure(error))
                        return
                    }

                    postDictionary["mediaURL"] = url?.absoluteString
                    postRef.setData(postDictionary) { error in
                        if let error = error {
                            print("Error creating Firestore document: \(error.localizedDescription)")
                            completion(.failure(error))
                        } else {
                            print("Successfully created Firestore document for post ID: \(postRef.documentID)")
                            completion(.success(()))
                        }
                    }
                }
            }
        } else {
            postRef.setData(postDictionary) { error in
                if let error = error {
                    print("Error creating Firestore document: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Successfully created Firestore document for post ID: \(postRef.documentID)")
                    completion(.success(()))
                }
            }
        }
    }

    func fetchComments(postId: String, completion: @escaping (Result<[Comment], Error>) -> Void) {
        db.collection("posts").document(postId).collection("comments").order(by: "createdAt", descending: true).getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            let comments = querySnapshot?.documents.map { Comment(id: $0.documentID, data: $0.data()) } ?? []
            completion(.success(comments))
        }
    }
}


