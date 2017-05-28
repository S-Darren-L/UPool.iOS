//
//  SignUpViewController.swift
//  UPool
//
//  Created by Darren on 2017-05-21.
//  Copyright © 2017 UPool.iOS. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    private var titleArray = [String]()
    private var titleSelectedRow: Int

    required init?(coder aDecoder: NSCoder) {
        self.titleArray = "TITLE_ARRAY".arrayLocalized
        self.titleSelectedRow = 0
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Init UI
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
        SignUpTitlePickerButton.setTitle(titleArray[titleSelectedRow], for: .normal)
        setButtonTextFieldStyle(button: SignUpTitlePickerButton)
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
    
    @IBAction func SelectTitle(_ sender: UIButton) {
        let titlePickerAlert = UIAlertController(title: "TITLE".localized, message: "\n\n\n", preferredStyle: UIAlertControllerStyle.actionSheet);
        titlePickerAlert.isModalInPopover = true;
        let pickerFrame: CGRect = CGRect(x:0, y:30, width:titlePickerAlert.view.bounds.size.width-20, height:100);
        
        let signUpTitlePickerView: UIPickerView = UIPickerView(frame: pickerFrame)
        signUpTitlePickerView.isHidden = false
        
        //set the pickers datasource and delegate
        signUpTitlePickerView.delegate = self
        signUpTitlePickerView.dataSource = self
        //Add the picker to the alert controller
        titlePickerAlert.view.addSubview(signUpTitlePickerView);
        
        
        titlePickerAlert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { (action: UIAlertAction!) in
            self.SignUpTitlePickerButton.setTitle(self.titleArray[self.titleSelectedRow], for: .normal)
        }))
        
        titlePickerAlert.addAction(UIAlertAction(title: "CANCEL".localized, style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        self.present(titlePickerAlert, animated: true, completion: nil);
    }
    
    //Set up title picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titleArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        titleSelectedRow = row
    }
    
    //Navigate back
    func navigateBack(sender:UIButton) {
        performNavigationBack()
    }
}




