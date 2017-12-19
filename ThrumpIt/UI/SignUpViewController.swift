//
//  SignUpViewController.swift
//  ThrumpIt
//
//  Created by Satish Kancherla on 12/19/17.
//  Copyright © 2017 Thrumpit. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
    }
    
    @IBAction func onTappingSignUpBtn(_ sender: UIButton) {
        submitSignUp()
    }
    
    @IBAction func onTappingCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField{
            if !validateName(){
                self.errorLabel.text = INVALIDNAME
                return false
            }else{
                self.errorLabel.text = ""
                self.emailTextField.becomeFirstResponder()
                return true
            }
        }else if textField == emailTextField{
            if !validateEmail(){
                self.errorLabel.text = INVALIDEMAIL
                return false
            }else{
                self.errorLabel.text = ""
                self.passwordTextField.becomeFirstResponder()
                return true
            }
        }else if textField == passwordTextField{
            return self.submitSignUp()
        }
        return true
    }
    
    
    func submitSignUp() -> Bool{
        var isvalid = true
        var errorText = ""
        if !validateName(){
            isvalid = false
            errorText = "\(INVALIDNAME)\n"
        }
        if !validateEmail(){
            isvalid = false
            errorText += "\(INVALIDEMAIL)\n"
        }
        if !validatePassword(){
            isvalid = false
            errorText += "\(INVALIDPASSWORD)"
        }
        self.errorLabel.text = errorText
        if isvalid{
            self.signUp()
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
    
    func validateName() -> Bool{
        guard let name = self.nameTextField.text?.replacingOccurrences(of: " ", with: "") else {return false}
        return name.count >= 2
    }
    
    func signUp(){
        guard let email = self.emailTextField.text, let name = self.nameTextField.text, let password = self.passwordTextField.text?.replacingOccurrences(of: " ", with: "") else {return}
        let params = ["name": name, "emailAddress": email, "reEnterEmailAddress": email, "password": password]
        AuthenticatorService.instance.register(params: params as [String : AnyObject], success: { (json) in
            self.showEmailVerifyPopup()
        }) { (error) in
            self.showError(error: error)
        }
    }
    
    func showEmailVerifyPopup(){
        let alertControlelr = UIAlertController(title: "Please activate your account", message: "Congratulations you are almost there !!!\nAn activation link is sent to your email address. Please click the link to activate your account.", preferredStyle: .alert)
        alertControlelr.addAction(UIAlertAction(title: "SignIn", style: .cancel, handler: { void in
            self.dismiss(animated: false, completion: {
                if let parentvc = self.presentingViewController as? ChallengeListViewController{
                    parentvc.openSignIn()
                }
            })
        }))
        self.present(alertControlelr, animated: true, completion: nil)
    }
    
    
}
