//
//  UIViewControllerExtension.swift
//  UPool
//
//  Created by Darren on 2017-05-21.
//  Copyright © 2017 UPool.iOS. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //Dismiss keyboard when tap around
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Navigate back to previous view
    func performNavigationBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //Set button background sign in style
    func setButtonSignInStyle(button: UIButton) {
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width:1, height:1)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1
    }
    
    //Set button background generalstyle
    func setButtonGeneralStyle(button: UIButton) {
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor(rgb: 0xBDBDBD)
        button.layer.cornerRadius = 3
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width:0.3, height:0.3)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.5
    }
    
    //Set button background TextField style
    func setButtonTextFieldStyle(button: UIButton) {
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5
        if let colorCode = Int("TEXT_FIELD_BORDER_COLOR".localized, radix: 16){
            button.layer.borderColor = UIColor(rgb: colorCode).cgColor}
        button.layer.borderWidth = 1
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 7, bottom: 2, right: 7)
    }
}
