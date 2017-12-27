//
//  BaseViewController.swift
//  ThrumpIt
//
//  Created by Satish Kancherla on 12/18/17.
//  Copyright © 2017 Thrumpit. All rights reserved.
//

import UIKit
import UIKit
import MBProgressHUD
import ObjectMapper

class BaseViewController: UIViewController {
    
    func showLoadingNotification(title: String = "", message: String = ""){
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = title
        loadingNotification.detailsLabel.text = message
    }
    
    func hideLoadingNotification(){
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }
    
    func showAlert(title: String = "", message: String = ""){
        let alertControlelr = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertControlelr.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertControlelr, animated: true, completion: nil)
    }
    
    func showError(error: ApiError){
        var title = "Service Error: \(error.code)", message = "Please try again!"
        if let msg = error.msg{
            message = msg
        }
        self.showAlert(title: title, message: message)
    }
    
}
