//
//  UserPreference.swift
//  ThrumpIt
//
//  Created by Satish Kancherla on 12/20/17.
//  Copyright © 2017 Thrumpit. All rights reserved.
//

import Foundation
class UserPreference: NSObject{
    static let instance = UserPreference()
    let loggedInUserKey = "LoggedInUser"
    
    func isLoggedIn() -> Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.value(forKey: loggedInUserKey){
            return true
        }else{
            return false
        }
    }
    
    func logInUser(){
        let defaults = UserDefaults.standard
        defaults.set("yes", forKey: loggedInUserKey)
        defaults.synchronize()
    }

    func logOutUser(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: loggedInUserKey)
        defaults.synchronize()
    }
}
