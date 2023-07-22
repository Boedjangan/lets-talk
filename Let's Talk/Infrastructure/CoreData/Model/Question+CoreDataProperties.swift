//
//  Question+CoreDataProperties.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 22/07/23.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var question: String?
    @NSManaged public var talkDuration: Int16
    @NSManaged public var updatedAt: Date?
    @NSManaged public var warmUp: String?
    @NSManaged public var answer: Answer?
    @NSManaged public var loveLog: LoveLog?
    @NSManaged public var subQuestion: NSSet?
    @NSManaged public var topic: Topic?

}

// MARK: Generated accessors for subQuestion
extension Question {

    @objc(addSubQuestionObject:)
    @NSManaged public func addToSubQuestion(_ value: SubQuestion)

    @objc(removeSubQuestionObject:)
    @NSManaged public func removeFromSubQuestion(_ value: SubQuestion)

    @objc(addSubQuestion:)
    @NSManaged public func addToSubQuestion(_ values: NSSet)

    @objc(removeSubQuestion:)
    @NSManaged public func removeFromSubQuestion(_ values: NSSet)

}

extension Question : Identifiable {

}
