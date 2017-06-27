//
//  UserAccount+CoreDataProperties.swift
//  
//
//  Created by Daniel Bessonov on 6/27/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension UserAccount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAccount> {
        return NSFetchRequest<UserAccount>(entityName: "UserAccount")
    }

    @NSManaged public var password: NSData?
    @NSManaged public var salt: String?
    @NSManaged public var username: String?

}
