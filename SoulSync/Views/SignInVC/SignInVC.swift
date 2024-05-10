//
//  SignInVC.swift
//  SoulSync
//
//  Created by Jeegrra on 03/04/2024.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import FirebaseFirestoreInternal

class SignInVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblErrorMsg: UILabel!
    @IBOutlet weak var btnGoogleSignIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        lblForgotPassword.addGestureRecognizer(tapGesture)
    }
    func setUpElements(){
        lblErrorMsg.alpha = 0
        txtEmail.layer.cornerRadius = 15.0
        txtEmail.layer.masksToBounds = true
        txtPassword.layer.cornerRadius = 15.0
        txtPassword.layer.masksToBounds = true
        btnSignIn.layer.cornerRadius = 15.0
        btnSignIn.layer.masksToBounds = true
        btnSignUp.layer.cornerRadius = 15.0
        btnSignUp.layer.masksToBounds = true
        btnGoogleSignIn.layer.cornerRadius = 15.0
        btnGoogleSignIn.layer.masksToBounds = true
        btnGoogleSignIn.layer.borderWidth = 2.0
                btnGoogleSignIn.layer.borderColor = UIColor.black.cgColor
    }
    func validateFields()->String?{
        
        // check that all fields are filled in
        
        if txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        // check if email is valid
        let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isEmailValid(email) == false {
            return "Please enter valid email"
        }
    
        // check if the password is secured
        let cleanPassword = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        return nil
    }
    
    func showError(_ message:String){
        lblErrorMsg.text = message
        lblErrorMsg.alpha = 1
    }
    
    func redirectToHomeScreen(){
        let mainTabBarController = MainTabBarController()
        view.window?.rootViewController = mainTabBarController
        view.window?.makeKeyAndVisible()
    }
    @objc func labelTapped() {
        let vc = ForgotPasswordVC(nibName: "ForgotPasswordVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }


    private func signInToFirebase(withCredential credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            guard let strongSelf = self else { return }

            if let error = error as NSError? {
                let errorCode = AuthErrorCode.Code(rawValue: error.code)  // Corrected type casting

                if let errorCode = errorCode {
                    switch errorCode {
                    case .emailAlreadyInUse:
                        // If the email associated with the Google account is already in use
                        strongSelf.showError("An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.")
                    default:
                        strongSelf.showError(error.localizedDescription)
                    }
                } else {
                    strongSelf.showError("An unknown error occurred")
                }
            } else {
                strongSelf.redirectToHomeScreen()
            }
        }
    }


    @IBAction func btnSignIn(_ sender: Any) {
        let error = validateFields()
        if let errorMessage = error {
            showError(errorMessage)
        } else {
            let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error != nil {
                    self.showError(error?.localizedDescription ?? "error creating user")
                } else {
                    self.redirectToHomeScreen()
                }
            }
        }
    }
    @IBAction func btnSignUp(_ sender: Any) {
        let vc = SignUpVC(nibName: "SignUpVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnGoogleSignIn(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                let config = GIDConfiguration(clientID: clientID)
                
                GIDSignIn.sharedInstance.configuration = config
                GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
                    guard error == nil else {
                        showError(error!.localizedDescription)
                        return
                    }
                    
                    guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                        showError("Error retrieving Google ID token")
                        return
                    }
                    
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                    
                    // Check if the user's email exists in the Firestore database
                    let email = user.profile?.email ?? ""
                    let db = Firestore.firestore()
                    db.collection("users").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
                        guard let snapshot = snapshot, error == nil else {
                            self.showError("Error checking user existence")
                            return
                        }
                        
                        if snapshot.isEmpty {
                            self.showError("You need to sign up first")
                        } else {
                            // User exists in the database, proceed with signing in
                            self.signInToFirebase(withCredential: credential)
                        }
                    }
                }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }    */
    
}
