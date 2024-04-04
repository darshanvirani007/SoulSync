//
//  ResetPasswordVC.swift
//  SoulSync
//
//  Created by Jeegrra on 04/04/2024.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnResetPassword: UIButton!
    @IBOutlet weak var lblErrorMsg: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements(){
        lblErrorMsg.alpha = 0
        txtPassword.layer.cornerRadius = 15.0
        txtPassword.layer.masksToBounds = true
        txtConfirmPassword.layer.cornerRadius = 15.0
        txtConfirmPassword.layer.masksToBounds = true
        btnResetPassword.layer.cornerRadius = 15.0
        btnResetPassword.layer.masksToBounds = true
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnResetPassword(_ sender: Any) {
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
