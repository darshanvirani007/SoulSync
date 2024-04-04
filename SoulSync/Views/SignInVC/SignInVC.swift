//
//  SignInVC.swift
//  SoulSync
//
//  Created by Jeegrra on 03/04/2024.
//

import UIKit

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
    @objc func labelTapped() {
        let vc = ForgotPasswordVC(nibName: "ForgotPasswordVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnSignIn(_ sender: Any) {
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
