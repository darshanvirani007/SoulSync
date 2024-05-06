//
//  ProfileVC.swift
//  SoulSync
//
//  Created by Jeegrra on 05/05/2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class ProfileVC: UIViewController {
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobileNo: UILabel!
    @IBOutlet weak var lblErrorMsg: UILabel!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var btnDeleteAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        loadUserInfo()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        lblErrorMsg.alpha = 0
        btnLogOut.layer.cornerRadius = 15.0
        btnLogOut.layer.masksToBounds = true
        btnDeleteAccount.layer.cornerRadius = 15.0
        btnDeleteAccount.layer.masksToBounds = true
    }
    
    func loadUserInfo() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Current user ID is nil.")
            return
        }
        
        print("Fetching user info for UserID: \(currentUserID)")
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(currentUserID)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                let firstName = (data?["first_name"] as? String ?? "").capitalized
                let lastName = (data?["last_name"] as? String ?? "").capitalized
                let fullName = "\(firstName) \(lastName)"
                
                self.lblName.text = fullName.isEmpty ? "N/A" : fullName
                self.lblEmail.text = data?["email"] as? String ?? "N/A"
                self.lblMobileNo.text = data?["mobileno"] as? String ?? "N/A"
            } else {
                print("Document does not exist for UserID: \(currentUserID)")
            }
        }
    }
    
    private func deleteUserData() {
        guard let currentUser = Auth.auth().currentUser else {
            print("User is not authenticated.")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(currentUser.uid)
        
        userRef.delete { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.lblErrorMsg.alpha = 1
                self.lblErrorMsg.text = "Error deleting user data: \(error.localizedDescription)"
                print("Error deleting user data: \(error.localizedDescription)")
                return
            }
            
            print("User data successfully deleted.")
            
            // Navigate to sign-in view controller after both user deletion and data deletion
            self.navigateToSignIn()
        }
    }


    
    func navigateToSignIn() {
        let vc = SignInVC(nibName: "SignInVC", bundle: nil)
        view.window?.rootViewController = UINavigationController(rootViewController: vc)
        view.window?.rootViewController = navigationController
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func btnEdit(_ sender: Any) {
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            print("User successfully logged out.")
            self.lblErrorMsg.text = "" // Clear error label if logout succeeds
            
            // Navigate to sign-in view controller
            self.navigateToSignIn()
        } catch {
            self.lblErrorMsg.alpha = 1
            self.lblErrorMsg.text = "Error logging out: \(error.localizedDescription)"
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    @IBAction func btnDeleteAccount(_ sender: Any) {
        guard let currentUser = Auth.auth().currentUser else {
               print("User is not authenticated.")
               return
           }
           
           // Delete user from Firebase Authentication
           currentUser.delete { [weak self] error in
               guard let self = self else { return }
               
               if let error = error {
                   self.lblErrorMsg.alpha = 1
                   self.lblErrorMsg.text = "Error deleting account: \(error.localizedDescription)"
                   print("Error deleting user: \(error.localizedDescription)")
                   return
               }
               
               // If the user is deleted from authentication, proceed to delete their data from Firestore
               self.deleteUserData()
           }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
