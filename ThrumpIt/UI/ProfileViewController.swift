//
//  ProfileViewController.swift
//  ThrumpIt
//
//  Created by Satish Kancherla on 12/27/17.
//  Copyright © 2017 Thrumpit. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet var signoutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signoutBtn.layer.cornerRadius = 3.0
        let barButton = UIBarButtonItem(customView: signoutBtn)
        self.navigationItem.rightBarButtonItem = barButton

    }

    @IBAction func doSignOut(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Sign out", message: "Are you sure want to sign out?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (void) in
            UserPreference.instance.logOutUser()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.launchApp()
        }))
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
