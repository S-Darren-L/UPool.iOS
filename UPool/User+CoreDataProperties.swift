//
//  User+CoreDataProperties.swift
//  UPool
//
//  Created by Darren on 2017-05-29.
//  Copyright © 2017 UPool.iOS. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var title: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

}
