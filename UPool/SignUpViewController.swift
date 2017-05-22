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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        //Set navigation bar title
        naviItem.title = "SIGN_UP".localized
        //Set navigation back button
        naviBackButton = UIBarButtonItem(title: "BACK".localized, style: .plain, target: self, action: #selector(navigateBack))
        naviBackButton.tintColor = UIColor.black
        naviItem.leftItemsSupplementBackButton = true
        naviItem.leftBarButtonItem = naviBackButton
    }
    
    func navigateBack(sender:UIButton) {
        performNavigationBack()
    }
}
