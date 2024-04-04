//
//  getStartedVC.swift
//  SoulSync
//
//  Created by Jeegrra on 03/04/2024.
//

import UIKit

class GetStartedVC: UIViewController {
    
    @IBOutlet weak var btnGetStarted: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
        btnGetStarted.layer.cornerRadius = 15.0
        btnGetStarted.layer.masksToBounds = true
    }
    
    @IBAction func btnGetStarted(_ sender: Any) {
        let vc = SignInVC(nibName: "SignInVC", bundle: nil)
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
