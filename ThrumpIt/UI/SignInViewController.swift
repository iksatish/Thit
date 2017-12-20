//
//  SignInViewController.swift
//  ThrumpIt
//
//  Created by Satish Kancherla on 12/19/17.
//  Copyright © 2017 Thrumpit. All rights reserved.
//
let INVALIDEMAIL = "Email is invalid."
let INVALIDPASSWORD = "Password is invalid."
let INVALIDNAME = "Name is invalid."


import UIKit

class SignInViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLabel: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign In"

    }

    @IBAction func onTappingSignInBtn(_ sender: UIButton) {
        self.submitSignIn()
    }
    
    @IBAction func onTappingCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            if !validateEmail(){
                self.errorLabel.text = INVALIDEMAIL
                return false
            }else{
                self.errorLabel.text = ""
                self.passwordTextField.becomeFirstResponder()
                return true
            }
        }else if textField == passwordTextField{
            return self.submitSignIn()
        }
        return true
    }
    

    func submitSignIn() -> Bool{
        var isvalid = true
        var errorText = ""
        if !validateEmail(){
            isvalid = false
            errorText = "\(INVALIDEMAIL)\n"
        }
        if !validatePassword(){
            isvalid = false
            errorText += "\(INVALIDPASSWORD)"
        }
        self.errorLabel.text = errorText
        if isvalid{
            self.signIn()
        }
        return isvalid
    }
    
    func validateEmail() -> Bool{
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self.emailTextField.text)
    }
    
    func validatePassword() -> Bool{
        guard let password = self.passwordTextField.text?.replacingOccurrences(of: " ", with: "") else {return false}
        return password.count >= 6
    }
    
    func signIn(){
        let params = ["uid": emailTextField.text, "password": passwordTextField.text]
        AuthenticatorService.instance.signIn(params: params as [String : AnyObject], success: { (user) in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            UserPreference.instance.logInUser()
            appDelegate.launchApp()
        }) { (error) in
            UserPreference.instance.logInUser()
            self.showError(error: error)
        }
    }
}
