//
//  ForgotPasswordVC.swift
//  SoulSync
//
//  Created by Jeegrra on 03/04/2024.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblErrorMsg: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements(){
        lblErrorMsg.alpha = 0
        txtEmail.layer.cornerRadius = 15.0
        txtEmail.layer.masksToBounds = true
        btnNext.layer.cornerRadius = 15.0
        btnNext.layer.masksToBounds = true
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        let vc = ResetPasswordVC(nibName: "ResetPasswordVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
