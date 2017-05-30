//
//  ISignUpModel.swift
//  UPool
//
//  Created by Darren on 2017-05-30.
//  Copyright © 2017 UPool.iOS. All rights reserved.
//

import Foundation

protocol ISignUpModel {
    var userContext: User { get set }
    init(user: User)
    func saveContext(user: User)
    func fetchRequest()
}
