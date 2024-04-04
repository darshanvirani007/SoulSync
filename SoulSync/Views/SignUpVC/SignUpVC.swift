//
//  SignUpVC.swift
//  SoulSync
//
//  Created by Jeegrra on 03/04/2024.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var txtFullName: UITextField!
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
        txtFullName.layer.cornerRadius = 15.0
        txtFullName.layer.masksToBounds = true
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
    @IBAction func btnSignUp(_ sender: Any) {
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
