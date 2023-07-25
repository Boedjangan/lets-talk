//
//  User+CoreDataProperties.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 22/07/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var coupleId: String?
    @NSManaged public var coupleName: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var gender: Int16
    @NSManaged public var talkDuration: Int64
    @NSManaged public var updatedAt: Date?
    @NSManaged public var username: String?
    @NSManaged public var id: UUID?
    @NSManaged public var loveLog: NSSet?

}

// MARK: Generated accessors for loveLog
extension User {

    @objc(addLoveLogObject:)
    @NSManaged public func addToLoveLog(_ value: LoveLog)

    @objc(removeLoveLogObject:)
    @NSManaged public func removeFromLoveLog(_ value: LoveLog)

    @objc(addLoveLog:)
    @NSManaged public func addToLoveLog(_ values: NSSet)

    @objc(removeLoveLog:)
    @NSManaged public func removeFromLoveLog(_ values: NSSet)

}

extension User : Identifiable {

}
