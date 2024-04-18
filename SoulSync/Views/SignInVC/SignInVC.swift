//
//  SignInVC.swift
//  SoulSync
//
//  Created by Jeegrra on 03/04/2024.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblErrorMsg: UILabel!
    
    
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
        let homeVC = HomeVC(nibName: "HomeVC", bundle: nil)
        view.window?.rootViewController = UINavigationController(rootViewController: homeVC)
        view.window?.rootViewController = navigationController
        view.window?.makeKeyAndVisible()
    }
    @objc func labelTapped() {
        let vc = ForgotPasswordVC(nibName: "ForgotPasswordVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }    */
    
}
