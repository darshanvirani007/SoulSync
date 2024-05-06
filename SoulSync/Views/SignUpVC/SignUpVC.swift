//
//  SignUpVC.swift
//  SoulSync
//
//  Created by Jeegrra on 03/04/2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class SignUpVC: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblErrorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements(){
        lblErrorMsg.alpha = 0
        txtFirstName.layer.cornerRadius = 15.0
        txtFirstName.layer.masksToBounds = true
        txtLastName.layer.cornerRadius = 15.0
        txtLastName.layer.masksToBounds = true
        txtEmail.layer.cornerRadius = 15.0
        txtEmail.layer.masksToBounds = true
        txtMobileNo.layer.cornerRadius = 15.0
        txtMobileNo.layer.masksToBounds = true
        txtPassword.layer.cornerRadius = 15.0
        txtPassword.layer.masksToBounds = true
        txtConfirmPassword.layer.cornerRadius = 15.0
        txtConfirmPassword.layer.masksToBounds = true
        btnSignUp.layer.cornerRadius = 15.0
        btnSignUp.layer.masksToBounds = true
    }
    
    func validateFields()->String?{
        
        // check that all fields are filled in
        
        if txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtMobileNo.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtConfirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        // check if email is valid
        let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isEmailValid(email) == false {
            return "Please enter valid email"
        }
        
        //check if mobile no is valid
        let mobileNo = txtMobileNo.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isMobileNumberValid(mobileNo) == false {
            return "Please enter valid mobile number"
        }
        // check if the password is secured
        let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPassword = txtConfirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if password != confirmPassword {
                return "Passwords do not match"
            }
        if Utilities.isPasswordValid(password) == false {
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
    
    @IBAction func btnSignUp(_ sender: Any) {
        //validae fields
        let error = validateFields()
        if let errorMessage = error {
            showError(errorMessage)
        } else {
            //create user
            let firstName = txtFirstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = txtLastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let mobileno = txtMobileNo.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                if err != nil{
                    self.showError(err?.localizedDescription ?? "error creating user")
                } else {
                    let db =  Firestore.firestore()
                    let uid = result!.user.uid // Get the UID of the newly created user
                    let userData: [String: Any] = [
                        "first_name": firstName,
                        "last_name": lastName,
                        "email": email,
                        "mobileno": mobileno,
                        "uid": uid
                    ]

                    // Specify the UID as the document ID when adding the document to Firestore
                    db.collection("users").document(uid).setData(userData) { error in
                        if let error = error {
                            self.showError("Error saving user data: \(error.localizedDescription)")
                        } else {
                            self.redirectToHomeScreen()
                            // Proceed with further actions, such as navigating to the next screen
                        }
                    }

                }
            }
        }
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
