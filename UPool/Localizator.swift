//
//  Localizator.swift
//  UPool
//
//  Created by Darren on 2017-05-21.
//  Copyright © 2017 UPool.iOS. All rights reserved.
//

import Foundation

private class Localizator {
    
    static let sharedInstance = Localizator()
    
    lazy var localizableDictionary: NSDictionary! = {
        if let path = Bundle.main.path(forResource: "Localizable", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        fatalError("Localizable file NOT found")
    }()
    
    func localize(string: String) -> String {
        guard let localizedString = (localizableDictionary.value(forKey: string) as AnyObject) as? String
            else {
                assertionFailure("Missing translation for: \(string)")
                return ""
        }
        return localizedString
    }
    
    func arrayLocalize(string: String) -> Array<String> {
        guard let localizedArray = (localizableDictionary.value(forKey: string) as AnyObject) as? Array<String> else{
            assertionFailure("Missing translation for: \(string)")
            return [String]()
        }
        return localizedArray
    }
}

extension String {
    var localized: String {
        return Localizator.sharedInstance.localize(string: self)
    }
    
    var arrayLocalized: Array<String>{
        var array = [String]()
        for item in Localizator.sharedInstance.arrayLocalize(string: self) {
            array.append(item)
        }
        return array
    }
}
