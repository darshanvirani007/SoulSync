import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    func signInAnonymously(completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let userId = authResult?.user.uid else {
                completion(.failure(NSError(domain: "AuthManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing user UID"])))
                return
            }
            completion(.success(userId))
        }
    }

    func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }

    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
