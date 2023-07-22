//
//  SubQuestion+CoreDataProperties.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 22/07/23.
//
//

import Foundation
import CoreData


extension SubQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubQuestion> {
        return NSFetchRequest<SubQuestion>(entityName: "SubQuestion")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var subQuestion: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: NSObject?
    @NSManaged public var question: Question?

}

extension SubQuestion : Identifiable {

}
