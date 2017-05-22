//
//  ViewController.swift
//  UPool
//
//  Created by Darren on 2017-05-19.
//  Copyright © 2017 UPool.iOS. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var SignInScrollView: UIScrollView!
    @IBOutlet var SignInEmailTextField: UITextField!
    @IBOutlet var SignInPasswordTextField: UITextField!
    @IBOutlet var SignUpButton: UIButton!
    @IBOutlet var SignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        SignInEmailTextField.placeholder = "EMAIL".localized
        SignInPasswordTextField.placeholder = "PASSWORD".localized
        SignUpButton.setTitle("SIGN_UP".localized, for: UIControlState.normal)
        SignInButton.setTitle("SIGN_IN".localized, for: UIControlState.normal)
        
        SignUpButton.layer.cornerRadius = 5
        SignUpButton.layer.shadowColor = UIColor.gray.cgColor
        SignUpButton.layer.shadowOffset = CGSize(width:1, height:1)
        SignUpButton.layer.shadowRadius = 5
        SignUpButton.layer.shadowOpacity = 1
        
        SignInButton.layer.cornerRadius = 5
        SignInButton.layer.shadowColor = UIColor.gray.cgColor
        SignInButton.layer.shadowOffset = CGSize(width:1, height:1)
        SignInButton.layer.shadowRadius = 5
        SignInButton.layer.shadowOpacity = 1
    }

    @IBAction func SignUp(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signUpViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.present(signUpViewController, animated: true, completion: nil)
    }
    
    //Push view up when keyboard shows up
    func textFieldDidBeginEditing(_ textField: UITextField) {
        SignInScrollView.setContentOffset(CGPoint(x:0, y:150), animated: true)
    }
    
    //Move view back when keyboard is dismissed
    func textFieldDidEndEditing(_ textField: UITextField) {
        SignInScrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    //Dismiss keyboard when Return button is clicked
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

