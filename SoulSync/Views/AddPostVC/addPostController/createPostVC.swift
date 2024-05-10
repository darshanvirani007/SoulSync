import UIKit
import Firebase

class createPostVC: UIViewController {
    @IBOutlet weak var txtContent: UITextField!
    @IBOutlet weak var imgSelectedMedia: UIImageView!
    @IBOutlet weak var selectedImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedImageView: UIView!
    @IBOutlet weak var btnClose: UIButton!
    
    var media: Data?
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCurrentUser()

        imgSelectedMedia.contentMode = .scaleAspectFill
        imgSelectedMedia.layer.cornerRadius = 10
        imgSelectedMedia.clipsToBounds = true
        hideSelectedImageView()
    }

    func fetchCurrentUser() {
        if let currentUserId = Auth.auth().currentUser?.uid {
            Firestore.firestore().collection("users").document(currentUserId).getDocument { document, error in
                if let document = document, document.exists {
                    self.currentUser = User(id: currentUserId, data: document.data() ?? [:])
                } else {
                    print("User does not exist")
                }
            }
        } else {
            redirectToLogin()
        }
    }

    @IBAction func btnShare(_ sender: Any) {
        guard let content = txtContent.text, !content.isEmpty else {
            showAlert(message: "Please write something to share.")
            return
        }

        guard let user = currentUser else {
            showAlert(message: "You are not logged in.")
            redirectToLogin()
            return
        }

        FirestoreManager.shared.createPost(content: content, user: user, media: media) { result in
            switch result {
            case .success:
                self.showAlert(message: "Post shared successfully!", dismiss: true)
            case .failure(let error):
                self.showAlert(message: "Error creating post: \(error.localizedDescription)")
                print("Error creating post: \(error.localizedDescription)")
            }
        }
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnCamera(_ sender: Any) {
        presentImagePicker(sourceType: .camera)
    }

    @IBAction func btnGallery(_ sender: Any) {
        presentImagePicker(sourceType: .photoLibrary)
    }

    @IBAction func btnClear(_ sender: Any) {
        txtContent.text = ""
        imgSelectedMedia.image = nil
        media = nil
        hideSelectedImageView()
    }

    @IBAction func btnClose(_ sender: Any) {
        media = nil
        imgSelectedMedia.image = nil
        hideSelectedImageView()
    }

    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            showAlert(message: "Selected source is not available.")
            return
        }

        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }

    private func redirectToLogin() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }

    private func showAlert(message: String, dismiss: Bool = false) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if dismiss {
                self.dismiss(animated: true, completion: nil)
            }
        })
        present(alert, animated: true, completion: nil)
    }

    private func hideSelectedImageView() {
        selectedImageViewHeightConstraint.constant = 0
        imgSelectedMedia.isHidden = true
        btnClose.isHidden = true
    }

    private func showSelectedImageView() {
        selectedImageViewHeightConstraint.constant = 240
        imgSelectedMedia.isHidden = false
        btnClose.isHidden = false
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension createPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            imgSelectedMedia.image = editedImage
            media = editedImage.jpegData(compressionQuality: 0.8)
        } else if let originalImage = info[.originalImage] as? UIImage {
            imgSelectedMedia.image = originalImage
            media = originalImage.jpegData(compressionQuality: 0.8)
        }

        showSelectedImageView()

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
