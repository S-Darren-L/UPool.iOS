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
        uiInit()
    }

    @IBAction func SignUp(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signUpViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.present(signUpViewController, animated: true, completion: nil)
    }
    
    @IBAction func SignIn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "VehicleRequest", bundle: nil)
        let vehicleRequestViewController = storyBoard.instantiateViewController(withIdentifier: "VehicleRequestViewController") as! VehicleRequestViewController
        self.present(vehicleRequestViewController, animated: true, completion: nil)
    }
    
    //UI init
    func uiInit(){
        self.hideKeyboardWhenTappedAround()
        
        SignInEmailTextField.placeholder = "EMAIL".localized
        SignInPasswordTextField.placeholder = "PASSWORD".localized
        SignUpButton.setTitle("SIGN_UP".localized, for: UIControlState.normal)
        setButtonSignInStyle(button: SignUpButton)
        SignInButton.setTitle("SIGN_IN".localized, for: UIControlState.normal)
        setButtonSignInStyle(button: SignInButton)
    }
    
    //Push view up when keyboard shows up
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation){
            SignInScrollView.setContentOffset(CGPoint(x:0, y:160), animated: true)
        }else if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            SignInScrollView.setContentOffset(CGPoint(x:0, y:60), animated: true)
        }
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

