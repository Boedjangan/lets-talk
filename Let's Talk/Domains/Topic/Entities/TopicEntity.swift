//
//  Topic.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

struct TopicEntity: Identifiable {
    var id: UUID = UUID()
    var iconName: String = ""
    var isActive: Bool = false
    var isCompleted: Bool = false
    var level: Int16 = 0
    var progress: Int16 = 0
    var title: String = ""
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}
