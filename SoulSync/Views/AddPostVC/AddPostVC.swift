//
//  AddPostVC.swift
//  SoulSync
//
//  Created by Jeegrra on 05/05/2024.
//

import UIKit

class AddPostVC: UIViewController {
    @IBOutlet weak var btnAddPost: UIButton!
    @IBOutlet weak var btnCreateGroup: UIButton!
    @IBOutlet weak var img_thoughts: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setAdaptiveImage()
    }

    func setAdaptiveImage() {
        if self.traitCollection.userInterfaceStyle == .dark {
            img_thoughts.image = UIImage(named: "img_thoughts_dark")
        } else {
            img_thoughts.image = UIImage(named: "img_thoughts")
        }
    }

    @IBAction func btnAddPost(_ sender: Any) {
        let createPostVC = createPostVC(nibName: "createPostVC", bundle: nil)
        self.present(createPostVC, animated: true, completion: nil)
    }

    @IBAction func btnCreateGroup(_ sender: Any) {
        // Your Create Group Action
    }
}
