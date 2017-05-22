//
//  SignUpViewController.swift
//  UPool
//
//  Created by Darren on 2017-05-21.
//  Copyright © 2017 UPool.iOS. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var naviItem: UINavigationItem!
    @IBOutlet var naviBackButton: UIBarButtonItem!
    @IBOutlet var SignUpScrollView: UIScrollView!
    @IBOutlet var SignUpEmailLabel: UILabel!
    @IBOutlet var SignUpEmailTextField: UITextField!
    @IBOutlet var SignUpPasswordLabel: UILabel!
    @IBOutlet var SignUpPasswordTextField: UITextField!
    @IBOutlet var SignUpTitleLabel: UILabel!
    @IBOutlet var SignUpTitlePickerButton: UIButton!
    @IBOutlet var SignUpFirstNameLabel: UILabel!
    @IBOutlet var SignUpFirstNameTextField: UITextField!
    @IBOutlet var SignUpLastNameLabel: UILabel!
    @IBOutlet var SignUpLastNameTextField: UITextField!
    @IBOutlet var SignUpRegisterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
    }
    
    //UI init
    func uiInit(){
        self.hideKeyboardWhenTappedAround()
        
        //Set navigation bar title
        naviItem.title = "SIGN_UP".localized
        //Set navigation back button
        naviBackButton = UIBarButtonItem(title: "BACK".localized, style: .plain, target: self, action: #selector(navigateBack))
        naviBackButton.tintColor = UIColor.black
        naviItem.leftItemsSupplementBackButton = true
        naviItem.leftBarButtonItem = naviBackButton
        
        SignUpEmailLabel.text = "EMAIL".localized
        SignUpEmailTextField.placeholder = "EMAIL".localized
        SignUpPasswordLabel.text = "PASSWORD".localized
        SignUpPasswordTextField.placeholder = "PASSWORD".localized
        SignUpTitleLabel.text = "TITLE".localized
//        SignUpPasswordTextField.placeholder = "PASSWORD".localized
        SignUpFirstNameLabel.text = "FIRST_NAME".localized
        SignUpFirstNameTextField.placeholder = "FIRST_NAME".localized
        SignUpLastNameLabel.text = "LAST_NAME".localized
        SignUpLastNameTextField.placeholder = "LAST_NAME".localized
        SignUpRegisterButton.setTitle("REGISTER".localized, for: .normal)
        setButtonGeneralStyle(button: SignUpRegisterButton)
    }
    
    //Push view up when keyboard shows up
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation){
            if(textField == SignUpFirstNameTextField) {
                SignUpScrollView.setContentOffset(CGPoint(x:0, y:200), animated: true)
            }
            else if(textField == SignUpLastNameTextField) {
                SignUpScrollView.setContentOffset(CGPoint(x:0, y:260), animated: true)
            }
        }
        else if UIDeviceOrientationIsPortrait(UIDevice.current.orientation){
            if(textField == SignUpFirstNameTextField
                || textField == SignUpLastNameTextField) {
                SignUpScrollView.setContentOffset(CGPoint(x:0, y:30), animated: true)
            }
        }
    }
    
    //Move view back when keyboard is dismissed
    func textFieldDidEndEditing(_ textField: UITextField) {
        SignUpScrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    //Dismiss keyboard when Return button is clicked
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func navigateBack(sender:UIButton) {
        performNavigationBack()
    }
}




