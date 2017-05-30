//
//  SignUpModels.swift
//  UPool
//
//  Created by Darren on 2017-05-29.
//  Copyright © 2017 UPool.iOS. All rights reserved.
//

import Foundation
import CoreData

class SignUpModel: ISignUpModel {
    
    let UserClassName:String = String(describing: User.self)
    var userContext: User
    
    required init(user: User){
        userContext = NSEntityDescription.insertNewObject(forEntityName: UserClassName, into: LocalRepositoryService.getContext()) as! User
    }
    
    func saveContext(user: User) {
        userContext.email = user.email
        userContext.title = user.title
        userContext.firstName = user.firstName
        userContext.lastName = user.lastName
        LocalRepositoryService.saveContext()
    }
    
    func fetchRequest() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try LocalRepositoryService.getContext().fetch(fetchRequest)
            print("number of results: \(searchResults.count)")
            for result in searchResults as [User] {
                print("\(result.firstName!) \(result.lastName!)")
            }
        } catch {
            print("Error: \(error)")
        }
        
        
    }
}
