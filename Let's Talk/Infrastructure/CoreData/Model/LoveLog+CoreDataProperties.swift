//
//  LoveLog+CoreDataProperties.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 22/07/23.
//
//

import Foundation
import CoreData


extension LoveLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoveLog> {
        return NSFetchRequest<LoveLog>(entityName: "LoveLog")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var question: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for question
extension LoveLog {

    @objc(addQuestionObject:)
    @NSManaged public func addToQuestion(_ value: Question)

    @objc(removeQuestionObject:)
    @NSManaged public func removeFromQuestion(_ value: Question)

    @objc(addQuestion:)
    @NSManaged public func addToQuestion(_ values: NSSet)

    @objc(removeQuestion:)
    @NSManaged public func removeFromQuestion(_ values: NSSet)

}

extension LoveLog : Identifiable {

}
