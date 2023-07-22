//
//  Topic+CoreDataProperties.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 22/07/23.
//
//

import Foundation
import CoreData


extension Topic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic> {
        return NSFetchRequest<Topic>(entityName: "Topic")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var iconName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var isCompleted: Bool
    @NSManaged public var level: Int16
    @NSManaged public var progress: Int16
    @NSManaged public var title: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var question: NSSet?

}

// MARK: Generated accessors for question
extension Topic {

    @objc(addQuestionObject:)
    @NSManaged public func addToQuestion(_ value: Question)

    @objc(removeQuestionObject:)
    @NSManaged public func removeFromQuestion(_ value: Question)

    @objc(addQuestion:)
    @NSManaged public func addToQuestion(_ values: NSSet)

    @objc(removeQuestion:)
    @NSManaged public func removeFromQuestion(_ values: NSSet)

}

extension Topic : Identifiable {

}
