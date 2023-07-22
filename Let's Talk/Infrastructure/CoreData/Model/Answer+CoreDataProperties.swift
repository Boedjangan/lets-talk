//
//  Answer+CoreDataProperties.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 22/07/23.
//
//

import Foundation
import CoreData


extension Answer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answer> {
        return NSFetchRequest<Answer>(entityName: "Answer")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var recordedAnswer: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var question: Question?

}

extension Answer : Identifiable {

}
